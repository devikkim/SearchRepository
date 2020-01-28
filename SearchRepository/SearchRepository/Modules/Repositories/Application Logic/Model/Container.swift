//
//  Container.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/27.
//  Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import ObjectMapper

struct Container: Mappable {
  var totalCount: Int?
  var incompleteResults: Bool?
  var items: [Repository]?
  
  init?(map: Map) {
  
  }
  
  mutating func mapping(map: Map) {
    totalCount <- map["total_count"]
    incompleteResults <- map["incomplete_results"]
    items <- map["items"]
  }
}
