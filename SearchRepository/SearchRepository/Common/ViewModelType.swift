//
//  ViewModelType.swift
//  GME Remit
//
//  Created by InKwon James Kim on 08/08/2019.
//  Copyright © 2019 Gobal Money Express Co. Ltd. All rights reserved.
//

protocol ViewModelType {
  associatedtype Input
  associatedtype Output
  
  func transform(input: Input) -> Output
}
