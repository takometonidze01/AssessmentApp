//
//  ColorType.swift
//  AppDesignSystem
//
//  Created by Tako Metonidze on 3/21/25.
//

import UIKit.UIColor

protocol ColorProviding {
  /// Mutate item to `Color`
  var asColor: UIColor { get }
}

public enum DynamicColorType: String, CaseIterable, ColorProviding {
  /// System
  case success = "Colors/System/success"
  case error = "Colors/System/error"
  case containerBackground = "Colors/System/container-background"
  case toastBackground = "Colors/System/toast-background"
  case toastTextColor = "Colors/System/toast-text-color"

  var asColor: UIColor {
    return UIColor(named: self.rawValue, in: .module, compatibleWith: .none)!
  }

  /// Return lighter version of primary color
  /// - Parameter version: `Int` version of color. Usually we have `1..7`
  /// - Returns: `Color`
  func version(_ version: Int) -> UIColor {
    guard version != 1 else {
      return asColor
    }

    let percentage = (Double(version) * 100.0 / 1000.0)
    return asColor.lighten(percentage)
  }
}

public enum StaticColorType: String, CaseIterable, ColorProviding {
  /// Text Colors
  case text1 = "Colors/Text/10"
  case text2 = "Colors/Text/20"
  case text3 = "Colors/Text/30"

  var asColor: UIColor {
    return UIColor(named: self.rawValue, in: .module, compatibleWith: nil)!
  }
}
