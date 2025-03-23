//
//  Presentation+UIColor.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/23/25.
//

import UIKit

public extension UIColor {
  convenience init?(hex: String) {
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

    var rgb: UInt64 = 0

    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var alpha: CGFloat = 1.0

    let length = hexSanitized.count

    guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
      return nil
    }

    if length == 6 {
      red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
      green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
      blue = CGFloat(rgb & 0x0000FF) / 255.0
    } else if length == 8 {
      red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
      green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
      blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
      alpha = CGFloat(rgb & 0x000000FF) / 255.0
    } else {
      return nil
    }

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

  convenience init(hex: String, alpha: CGFloat = 1.0) {
    var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

    if hexValue.hasPrefix("#") {
      hexValue.remove(at: hexValue.startIndex)
    }

    if hexValue.count == 3 {
      hexValue = "\(hexValue)\(hexValue)"
    }

    var rgbValue: UInt64 = 0
    Scanner(string: hexValue).scanHexInt64(&rgbValue)

    let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
    let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
