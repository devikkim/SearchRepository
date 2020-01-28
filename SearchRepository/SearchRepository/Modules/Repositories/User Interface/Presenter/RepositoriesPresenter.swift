//
//  RepositoriesPresenter.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/28.
//Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import RxSwift
import RxCocoa

class RepositoriesPresenter: ViewModelType {
  var interactor: RepositoriesInteractorInput?
  var wireframe: RepositoriesWireframeInput?
  
  struct Input {
    let viewWillAppear: Driver<Void>
    let didEnd: Driver<Bool>
    let search: Driver<String>
  }
  
  struct Output {
    let isError: Driver<Error>
    let isProgress: Driver<Bool>
    let repository: Driver<[Repository]>
  }

  private let disposeBag = DisposeBag()
  
  private let progressLinker = PublishSubject<Bool>()
  private let errorLinker = PublishSubject<Error>()
  private let repositories = PublishSubject<[Repository]>()
  
  func transform(input: Input) -> Output {
    Driver.combineLatest(input.search, input.viewWillAppear).map { $0.0 }
      .drive(onNext: {[weak self] in
        self?.progressLinker.onNext(true)
        self?.interactor?.searchRepository(text: $0)
      }).disposed(by: disposeBag)
    
    input.didEnd.drive(onNext: {[weak self] in
      if $0 {
        self?.progressLinker.onNext(true)
        self?.interactor?.fetchNextPage()
      }
    }).disposed(by: disposeBag)
    
    return Output(
      isError: errorLinker.asDriverOnErrorJustComplete(),
      isProgress: progressLinker.asDriverOnErrorJustComplete(),
      repository: repositories.asDriverOnErrorJustComplete()
    )
  }
}

// MARK: Repositories interactor output interface
extension RepositoriesPresenter: RepositoriesInteractorOutput {
  func setRepositories(_ repositories: [Repository]) {
    progressLinker.onNext(false)
    self.repositories.onNext(repositories)
  }
  
  func setError(with error: Error) {
    progressLinker.onNext(false)
    errorLinker.onNext(error)
  }
}
