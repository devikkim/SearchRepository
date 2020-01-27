//
//  RepositoryViewController.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/27.
//  Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoryViewController: UIViewController {
  
  @IBOutlet private weak var searchBar: UISearchBar!
  @IBOutlet private weak var tableView: UITableView!
  
  var viewModel: RepositoryViewModel!
  
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setBinding()
  }
  
  private func setBinding() {
    let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
      .map { _ in }.asDriver(onErrorJustReturn: ())
    
    let input = RepositoryViewModel.Input(
      viewWillAppear: viewWillAppear,
      search: searchBar.rx.text.orEmpty.asDriver().throttle(.milliseconds(300), latest: true)
    )
    
    let output = viewModel.transform(input: input)
    
    output.progress.drive(onNext: {[weak self] in
      $0 ? self?.showProgressHud() : self?.hideProgressHud()
      }).disposed(by: disposeBag)
    
    output.error.drive(onNext: {[weak self] in
      self?.alert(
        title: "에러",
        message: $0.localizedDescription,
        rightButtonTitle: "확인"
      )
    }).disposed(by: disposeBag)
    
    output
      .repository
      .drive(
        tableView.rx.items(cellIdentifier: "RepositoryCell")
      ) {(_, element: Repository, cell: RepositoryCell) in
        cell.setModel(with: element)
    }
    .disposed(by: disposeBag)
  }
}
