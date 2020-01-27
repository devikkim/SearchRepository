//
//  APIManager.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/23.
//  Copyright © 2020 InKwon Devik Kim. All rights reserved.
//
import Alamofire

class APIManager {
  static let shared = APIManager()
  let manager: SessionManager
  
  init() {
    let configure = URLSessionConfiguration.default
    configure.timeoutIntervalForRequest = 30.0
    configure.timeoutIntervalForResource = 30.0
    
    manager = Alamofire.SessionManager(configuration: configure)
  }
}
