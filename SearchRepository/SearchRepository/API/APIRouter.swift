//
//  APIRouter.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/23.
//  Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper

enum APIRouter {
  case search(text: String)
}

extension APIRouter {
  private var endpoint: String {
    switch self {
    case .search(let text):
      return "https://api.github.com/search/repositories?q=\(text)"
    }
  }
  
  private var method: HTTPMethod {
    switch self {
    case .search: return .get
    }
  }
}

extension APIRouter {
  private var manager: SessionManager {
    return APIManager.shared.manager
  }
  
  func json<Element: Mappable>(
    encoding: ParameterEncoding = JSONEncoding.default,
    needsAuthorization: Bool = true,
    success: @escaping (Element) -> Void,
    failure: @escaping (Error) -> Void
  ) {
    guard
      let isReachable = NetworkReachabilityManager()?.isReachable,
      isReachable else {
        let error = NSError(
          domain: "NETWORK_REACHABILITY_DOMAIN",
          code: -99,
          message: "No Internet connection found. Check your connection."
        )
        return failure(error)
    }
    
    manager.request(
      self.endpoint,
      method: self.method,
      parameters: nil,
      encoding: encoding
    ).responseObject { (response: DataResponse<Element>) in
      switch response.result {
      case .success(let value):
        success(value)
      case .failure(let error):
        failure(error)
      }
    }
  }
}
