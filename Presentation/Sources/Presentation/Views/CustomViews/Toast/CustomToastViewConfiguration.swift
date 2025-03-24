//
//  CustomToastViewConfiguration.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/24/25.
//

import UIKit

public struct CustomToastViewConfiguration {
  public var title: String
  public var description: String?
  public var type: ToastType

  public init(title: String, description: String? = nil, type: ToastType) {
    self.title = title
    self.description = description
    self.type = type
  }
}

public extension CustomToastViewConfiguration {
  enum ToastType {
    case error
    case success

    var image: Image {
      switch self {
      case .error:
        return .redError
      case .success:
        return .greenSuccess
      }
    }
  }
}
