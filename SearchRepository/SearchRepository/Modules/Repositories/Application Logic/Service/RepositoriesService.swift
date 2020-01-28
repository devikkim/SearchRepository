//
//  RepositoriesService.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/28.
//Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import Foundation

class RepositoriesService: RepositoriesServiceType {
  func searchRepository(
    _ text: String,
    success: @escaping (Container) -> Void,
    failure: @escaping (Error) -> Void
  ) {
    APIRouter.search(text: text).json(success: success, failure: failure)
  }
  
  func fetchNextPage(
    _ text: String,
    _ page: Int,
    success: @escaping (Container) -> Void,
    failure: @escaping (Error) -> Void
  ) {
    APIRouter.next(text: text, page: page).json(success: success, failure: failure)
  }
}
