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
  private let progress = PublishSubject<Bool>()
  private let error = PublishSubject<Error>()
  init(service: RepositoryService) {
    self.service = service
  }
  
  struct Input {
    let viewWillAppear: Driver<Void>
    let search: Driver<String>
  }
  
  struct Output {
    let progress: Driver<Bool>
    let error: Driver<Error>
    let repository: Driver<[Repository]>
  }
  
  func transform(input: Input) -> Output {
    Driver.combineLatest(input.search, input.viewWillAppear).map { $0.0 }
      .drive(onNext: {[weak self] in
        self?.progress.onNext(true)
        self?.service?.searchRepository(
          $0,
          success: {
            self?.progress.onNext(false)
            self?.repository.onNext($0.items ?? [])
          },
          failure: {
            self?.progress.onNext(false)
            self?.error.onNext($0)
        })
      }).disposed(by: disposeBag)
    return Output(
      progress: progress.asDriver(onErrorJustReturn: false),
      error: error.asDriver(onErrorJustReturn: NSError(domain: "Error", code: 0, message: "Something Error")),
      repository: repository.asDriver(onErrorJustReturn: [])
    )
  }
}
