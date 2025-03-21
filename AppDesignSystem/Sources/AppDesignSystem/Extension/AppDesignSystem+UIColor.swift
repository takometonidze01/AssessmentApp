//
//  AppDesignSystem+UIColor.swift
//  AppDesignSystem
//
//  Created by Tako Metonidze on 3/21/25.
//

import UIKit.UIColor
import SwiftUI

public extension UIColor {
  static subscript(colorType: DynamicColorType, version: Int = 1) -> UIColor {
    return ColorProvider.shared[colorType, version]
  }

  static subscript(colorType: StaticColorType) -> UIColor {
    return ColorProvider.shared[colorType]
  }

  /// Make a color lighter
  /// - Parameter alpha: `CGFloat` percentage. for example 0.2 will cause color to be 20% lighter
  /// - Returns: `UIColor`
  func lighten(_ alpha: CGFloat) -> UIColor {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    guard self.getRed(&r, green: &g, blue: &b, alpha: &a) else {
      return self
    }
    return UIColor(red: r + (1.0-r) * alpha, green: g + (1.0-g) * alpha, blue: b + (1.0-b) * alpha, alpha: a)
  }
}

public extension SwiftUI.Color {
  static subscript(colorType: DynamicColorType, version: Int = 1) -> SwiftUI.Color {
    return SwiftUI.Color(ColorProvider.shared[colorType, version])
  }

  static subscript(colorType: StaticColorType) -> SwiftUI.Color {
    return SwiftUI.Color(ColorProvider.shared[colorType])
  }
}
