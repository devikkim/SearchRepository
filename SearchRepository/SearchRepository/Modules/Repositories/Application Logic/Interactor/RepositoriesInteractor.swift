//
//  RepositoriesInteractor.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/28.
//Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import Foundation

class RepositoriesInteractor {
  
  // MARK: Properties
  
  weak var output: RepositoriesInteractorOutput?
  private let service: RepositoriesServiceType
  private var search = ""
  private var page = 1
  private var repositories = [Repository]()
  // MARK: Initialization
  
  init(service: RepositoriesServiceType) {
    self.service = service
  }
  
}

// MARK: Repositories interactor input interface

extension RepositoriesInteractor: RepositoriesInteractorInput {
  func searchRepository(text: String) {
    if text != search {
      page = 1
    }
    
    search = text
    
    service.searchRepository(
      text,
      success: {[weak self] in
        guard let repositories = $0.items else {
          self?.output?.setRepositories([])
          return
        }
        
        self?.repositories = repositories
        self?.output?.setRepositories(repositories)
      },
      failure: {[weak self] in
        self?.repositories = []
        self?.output?.setError(with: $0)
    })
  }
  
  func fetchNextPage() {
    page += 1
    
    service.fetchNextPage(
      search,
      page,
      success: {[weak self] in
        guard let `self` = self else { return }
        
        guard let nextRepository = $0.items else {
          let error = NSError(domain: "Repository", code: 0, message: "다음 페이지가 존재하지 않습니다.")
          self.output?.setError(with: error)
          return
        }
        
        self.repositories.append(contentsOf: nextRepository)
        self.output?.setRepositories(self.repositories)
      },
      failure: {[weak self] in
        self?.output?.setError(with: $0)
    })
  }
}
