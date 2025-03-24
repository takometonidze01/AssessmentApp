//
//  FontFamily.swift
//  AppDesignSystem
//
//  Created by Tako Metonidze on 3/21/25.
//

import Foundation

enum FontFamily: String {
  case system
  case poppins = "Poppins"

  var name: String {
    return self.rawValue
  }

  var fontFiles: [String] {
    switch self {
    case .poppins:
      return [
        "Poppins-Regular.ttf",
        "Poppins-SemiBold.ttf"
      ]
    default:
      return []
    }
  }
}
