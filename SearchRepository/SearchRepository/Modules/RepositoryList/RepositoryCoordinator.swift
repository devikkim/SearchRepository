//
//  RepositoryCoordinator.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/27.
//  Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import UIKit

class RepositoryCoordinator: Coordinator {
  var storyboardName: String {return "Main"}
  
  weak var view: UIViewController!
  
  func getMainView() -> UIViewController {
    let service = RepositoryService()
    let viewModel = RepositoryViewModel(service: service)
    let viewController = viewControllerFromStoryboard(of: RepositoryViewController.self)
    
    viewController.viewModel = viewModel
    viewModel.coordinator = self
    
    view = viewController
    return viewController
  }
}
