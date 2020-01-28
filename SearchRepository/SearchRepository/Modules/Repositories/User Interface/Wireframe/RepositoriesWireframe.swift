//
//  RepositoriesWireframe.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/28.
//Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import UIKit

class RepositoriesWireframe {
  weak var view: UIViewController!
}

extension RepositoriesWireframe: RepositoriesWireframeInput {
  
  var storyboardName: String {return "Repositories"}
  
  func getMainView() -> UIViewController {
    let service = RepositoriesService()
    let interactor = RepositoriesInteractor(service: service)
    let presenter = RepositoriesPresenter()
    let viewController = viewControllerFromStoryboard(of: RepositoriesViewController.self)
    
    viewController.presenter = presenter
    interactor.output = presenter
    presenter.interactor = interactor
    presenter.wireframe = self
    
    view = viewController
    return viewController
  }
  
  func viewControllerFromStoryboard<T: UIViewController>(of type: T.Type) -> T {
     return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(
       withIdentifier: String(describing: T.self)
       ) as! T
   }
}
