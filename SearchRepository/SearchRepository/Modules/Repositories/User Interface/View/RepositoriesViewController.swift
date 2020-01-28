//
//  RepositoriesViewController.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/28.
//Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoriesViewController: UIViewController {
  
  // MARK: Properties
  var presenter: RepositoriesPresenter!
  
  private let disposeBag = DisposeBag()
  private let interval = 30
  // MARK: Computed Properties
  
  // MARK: IBOutlets
  @IBOutlet private weak var searchBar: UISearchBar!
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var noHaveItemLabel: UILabel!
  
  // MARK: VC's Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    searchBar.becomeFirstResponder()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }
  
  // MARK: IBActions

}

// MARK: Other Functions
extension RepositoriesViewController {
  
  private func setup() {
    setUI()
    setBinding()
    setUIBinding()
  }
  
  private func setUI() {
    
  }
  
  private func setUIBinding() {
    searchBar.rx.searchButtonClicked.asDriver().drive(onNext: {[weak self] in
      self?.searchBar.resignFirstResponder()
    }).disposed(by: disposeBag)
    
    tableView.rx.willEndDragging.asDriver().map {_ in }.drive(onNext: {[weak self] in
      self?.searchBar.resignFirstResponder()
    }).disposed(by: disposeBag)

  }

  private func setBinding() {
    let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
      .map { _ in }.asDriverOnErrorJustComplete()
    
    let didEnd = PublishSubject<Bool>()
    
    let search = searchBar.rx.searchButtonClicked.withLatestFrom(searchBar.rx.text.orEmpty) { $1 }
      .asDriverOnErrorJustComplete()
    
    let input = RepositoriesPresenter.Input(
      viewWillAppear: viewWillAppear,
      didEnd: didEnd.asDriverOnErrorJustComplete(),
      search: search
    )
    
    let output = presenter.transform(input: input)

    output.isError
    .drive(
      onNext: { self.alert(message: $0.localizedDescription) }
    ).disposed(by: disposeBag)
    
    output.isProgress
    .drive(
      onNext: { $0 ? self.showProgressHud() : self.hideProgressHud() }
    ).disposed(by: disposeBag)
    
    output
      .repository
      .drive(
        tableView.rx.items(cellIdentifier: "RepositoryCell")
      ) {(_, element: Repository, cell: RepositoryCell) in
        cell.setModel(with: element)
    }
    .disposed(by: disposeBag)
    
    output.repository.map {$0.count != 0}
      .drive(noHaveItemLabel.rx.isHidden)
      .disposed(by: disposeBag)
    
    tableView.rx.willDisplayCell.map{ $0.1}.withLatestFrom(output.repository) {($0, $1)}
      .map {[weak self] (indexPath, repositories) -> Bool in
        if indexPath.row + 1 == repositories.count && (repositories.count % (self?.interval ?? 30)) == 0 {
          return true
        }
        return false
      }.bind(to: didEnd).disposed(by: disposeBag)
  }
}
