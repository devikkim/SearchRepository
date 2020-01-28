//
//  RepositoriesInteractorIO.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/28.
//Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

protocol RepositoriesInteractorInput: class {
  func searchRepository(text: String)
  func fetchNextPage()
}

protocol RepositoriesInteractorOutput: class {
  func setRepositories(_ repositories: [Repository])
  func setError(with error: Error)
}
