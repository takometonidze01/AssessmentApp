//
//  FormService.swift
//  Networking
//
//  Created by Tako Metonidze on 3/23/25.
//

import UIKit
import Moya

public enum FormService {
  case getFormData
}

extension FormService: CustomTargetType {
  public var path: String {
    switch self {
    case .getFormData:
      return "/v3/d403fba7-413f-40d8-bec2-afe6ef4e201e"
    }
  }

  public var method: Moya.Method {
    switch self {
    case .getFormData:
      return .get
    }
  }

  public var task: Moya.Task {
    switch self {
    case .getFormData:
      return .requestPlain
    }
  }
}
