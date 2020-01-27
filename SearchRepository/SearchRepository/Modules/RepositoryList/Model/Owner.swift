//
//  Owner.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/27.
//  Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import ObjectMapper

struct Owner: Mappable {
  var id: Int?
  var nodeID: String?
  var avatarURL: String?
  var gravatarID: String?
  var url: String?
  var receivedEventsURL: String?
  var type: String?
  
  init?(map: Map) {
    
  }
  
  mutating func mapping(map: Map) {
    id <- map["id"]
    nodeID <- map["node_id"]
    avatarURL <- map["avatar_url"]
    gravatarID <- map["gravatar_id"]
    url <- map["url"]
    receivedEventsURL <- map["received_events_url"]
    type <- map["type"]
  }
}
