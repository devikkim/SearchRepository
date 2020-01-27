//
//  Coordinator.swift
//  CoupleMaching
//
//  Created by InKwon James Kim on 2020/01/21.
//  Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import UIKit

protocol Coordinator {
  var window: UIWindow? {get}
  var view: UIViewController! {get}
  var storyboardName: String {get}
  func getMainView() -> UIViewController
}

extension Coordinator {
  var window: UIWindow? {
    return UIApplication.shared.windows.first
  }
  
  func viewControllerFromStoryboard<T: UIViewController>(of type: T.Type) -> T {
    return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
      withIdentifier: String(describing: T.self)
      ) as! T
  }
}
