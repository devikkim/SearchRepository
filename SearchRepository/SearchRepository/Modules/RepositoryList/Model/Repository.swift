//
//  Repository.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/27.
//  Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import ObjectMapper

struct Repository: Mappable {
  var id: Int?
  var nodeID: String?
  var name: String?
  var fullName: String?
  var owner: Owner?
  var `private`: Bool?
  var htmlURL: String?
  var description: String?
  var fork: Bool?
  var url: String?
  var createdAt: String?
  var updatedAt: String?
  var pushedAt: String?
  var homePage: String?
  var size: Int?
  var stargazersCount: Int?
  var watchersCount: Int?
  var language: String?
  var forkCount: Int?
  var openIssuesCount: Int?
  var masterBranch: String?
  var defaultBranch: String?
  var score: Double?
  
  init?(map: Map) {
  }
  
  mutating func mapping(map: Map) {
    id <- map["id"]
    nodeID <- map["node_id"]
    name <- map["name"]
    fullName <- map["fullName"]
    owner <- map["owner"]
    `private` <- map["private"]
    htmlURL <- map["html_url"]
    description <- map["description"]
    fork <- map["fork"]
    url <- map["url"]
    createdAt <- map["created_at"]
    updatedAt <- map["updated_at"]
    pushedAt <- map["pushed_at"]
    homePage <- map["homepage"]
    size <- map["size"]
    stargazersCount <- map["stargazers_count"]
    watchersCount <- map["watchers_count"]
    language <- map["language"]
    forkCount <- map["forks_count"]
    openIssuesCount <- map["open_issues_count"]
    masterBranch <- map["master_branch"]
    defaultBranch <- map["default_branch"]
    score <- map["score"]
  }
}
