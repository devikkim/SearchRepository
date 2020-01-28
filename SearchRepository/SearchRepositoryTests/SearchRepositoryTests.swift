//
//  SearchRepositoryTests.swift
//  SearchRepositoryTests
//
//  Created by InKwon James Kim on 2020/01/23.
//  Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import XCTest
@testable import SearchRepository

class SearchRepositoryTests: XCTestCase {
  func testAPI() {
    let expt = expectation(description: "test.api")
    
    let success: (Container) -> Void = { (container) in
      XCTAssert(container.items?.count != 0, "searched count")
      expt.fulfill()
    }
    
    let failure: (Error) -> Void = { (error) in
      XCTAssert(false, error.localizedDescription)
      expt.fulfill()
    }
    
    APIRouter.search(text: "Alamofire")
      .json(success: success, failure: failure)
    
    wait(for: [expt], timeout: 5.0)
  }

}
