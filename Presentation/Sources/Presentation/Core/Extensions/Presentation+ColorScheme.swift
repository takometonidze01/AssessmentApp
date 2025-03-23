//
//  Presentation+ColorScheme.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/21/25.
//

import SwiftUICore
import Domain

extension ColorScheme {
  var isDarkMode: Bool {
    self == .dark
  }

  var colorValue: ColorValue {
    self.isDarkMode ? .dark : .light
  }
}
