//
//  WireframeInput.swift
//  GMERemittance
//
//  Created by gme_2 on 24/08/2018.
//  Copyright © 2018 Gobal Money Express Co. Ltd. All rights reserved.
//

import UIKit

protocol WireframeInput {
  var window: UIWindow? {get}
  var view: UIViewController! {get}
  var storyboardName: String {get}

  func getMainView() -> UIViewController
}

extension WireframeInput {
  var window: UIWindow? {
    return UIApplication.shared.keyWindow
  }
}
