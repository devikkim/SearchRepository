//
//  RepositoryService.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/27.
//  Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import Foundation

class RepositoryService {
  func searchRepository(
    _ text: String,
    success: @escaping (Container) -> Void,
    failure: @escaping (Error) -> Void
  ) {
    APIRouter.search(text: text).json(success: success, failure: failure)
  }
}
