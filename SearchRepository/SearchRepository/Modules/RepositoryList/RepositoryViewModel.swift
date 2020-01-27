//
//  RepositoryViewModel.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/27.
//  Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import RxSwift
import RxCocoa

class RepositoryViewModel {
  var coordinator: RepositoryCoordinator?
  
  private let disposeBag = DisposeBag()
  private let service: RepositoryService?
  
  private let repository = PublishSubject<[Repository]>()
  init(service: RepositoryService) {
    self.service = service
  }
  
  struct Input {
    let viewWillAppear: Driver<Void>
    let search: Driver<String>
  }
  
  struct Output {
    let repository: Driver<[Repository]>
  }
  
  func transform(input: Input) -> Output {
    return Output(repository: repository.asDriver(onErrorJustReturn: []))
  }
}
