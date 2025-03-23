//
//  File.swift
//  Networking
//
//  Created by Tako Metonidze on 3/21/25.
//

import UIKit
import Moya

public protocol CustomTargetType: Moya.TargetType, Moya.AccessTokenAuthorizable {
  var mayRunAsBackgroundTask: Bool { get }
}

public extension CustomTargetType {
  var baseURL: URL {
    fatalError("Use CustomMultiTarget")
  }

  var validationType: ValidationType {
    return .successCodes
  }

  var headers: [String: String]? {
    return [
      "Content-Type": "application/json",
      "Accept": "application/json"
    ]
  }

  var authorizationType: Moya.AuthorizationType? {
    .custom("")
  }

  var mayRunAsBackgroundTask: Bool {
    false
  }
}
