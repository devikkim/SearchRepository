//
//  RepositoriesServiceType.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/28.
//Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

protocol RepositoriesServiceType: class {
  func searchRepository(
    _ text: String,
    success: @escaping (Container) -> Void,
    failure: @escaping (Error) -> Void
  )
  
  func fetchNextPage(
    _ text: String,
    _ page: Int,
    success: @escaping (Container) -> Void,
    failure: @escaping (Error) -> Void
  )
}
