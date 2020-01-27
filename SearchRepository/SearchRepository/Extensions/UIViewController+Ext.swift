//
//  UIViewController+Ext.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/27.
//  Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController {
  func showProgressHud(
    backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.8),
    loadingColor: UIColor = .white,
    textColor: UIColor = .white
  ) {
    let activityData = ActivityData(
      size: CGSize(width: 50, height: 50),
      message: "Loading",
      messageSpacing: 2,
      type: .lineScale,
      color: loadingColor,
      padding: 5,
      backgroundColor: backgroundColor,
      textColor: textColor
    )
    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
  }
  
  func hideProgressHud() {
    NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
  }
  
  func alert(
    title: String = "경고",
    message: String? = nil,
    rightButtonTitle: String = "확인",
    leftButtonTitle: String? = "취소",
    rightButtonAction: (() -> Void)? = nil,
    leftButtonAction: (() -> Void)? = nil
  ) {
    let dialog = UIAlertController(title: "제목", message: "내용", preferredStyle: .alert)
    
    let rightAction = UIAlertAction(title: rightButtonTitle, style: .default) { _ in
      rightButtonAction?()
    }
    
    let leftAction = UIAlertAction(title: leftButtonTitle, style: .default) { _ in
      leftButtonAction?()
    }
    
    
    dialog.addAction(rightAction)
    
    if leftButtonAction != nil {
      dialog.addAction(leftAction)
    }
    self.present(dialog, animated: true, completion: nil)
  }
}
