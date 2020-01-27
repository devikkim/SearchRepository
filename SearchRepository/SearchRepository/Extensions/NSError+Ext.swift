//
//  NSError+Ext.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/23.
//  Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import Foundation

extension NSError {
  convenience init(domain: String, code: Int, message: String) {
    self.init(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: message])
  }
}
