//
//  RepositoryViewController.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/27.
//  Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController {
  
  @IBOutlet private weak var searchBar: UISearchBar!
  @IBOutlet private weak var tableView: UITableView!
  
  var viewModel: RepositoryViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setBinding()
  }
  
  private func setBinding() {
    let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
      .map { _ in }.asDriver(onErrorJustReturn: ())
    
    let input = RepositoryViewModel.Input(
      viewWillAppear: viewWillAppear,
      search: searchBar.rx.text.orEmpty.asDriver()
    )
    
    let output = viewModel.transform(input: input)
    
  }
}
