//
//  AppDesignSystem+Font.swift
//  AppDesignSystem
//
//  Created by Tako Metonidze on 3/21/25.
//

import UIKit.UIFont
import SwiftUI

public extension UIFont {
  /// Poppins font builder
  static func poppins(size: CGFloat, weight: UIFont.Weight = .regular, relativeTo textStyle: UIFont.TextStyle, isItalic: Bool = false) -> UIFont {
    FontProvider.shared.custom(.poppins, size: size, style: textStyle, weight: weight, italic: isItalic)
  }

  // MARK: Headings
  /// Poppins - 32pt - bold
  static let h1: UIFont = FontProvider.shared[.h1]

  // MARK: Buttons
  /// Poppins - 12pt - regular
  static let button: UIFont = FontProvider.shared[.button]

  // MARK: Body
  /// Poppins - 20pt - regular
  static let body1: UIFont = FontProvider.shared[.body1]

  /// Poppins - 14pt - regular
  static let body2: UIFont = FontProvider.shared[.body2]
}

public extension UIFont {
  var monospacedDigitFont: UIFont {
    let oldFontDescriptor = fontDescriptor
    let newFontDescriptor = oldFontDescriptor.monospacedDigitFontDescriptor
    return UIFont(descriptor: newFontDescriptor, size: 0)
  }
}

private extension UIFontDescriptor {
  var monospacedDigitFontDescriptor: UIFontDescriptor {
    let fontDescriptorFeatureSettings = [
      [
        UIFontDescriptor.FeatureKey.type: kNumberSpacingType,
        UIFontDescriptor.FeatureKey.selector: kMonospacedNumbersSelector
      ]
    ]
    let fontDescriptorAttributes = [UIFontDescriptor.AttributeName.featureSettings: fontDescriptorFeatureSettings]
    let fontDescriptor = self.addingAttributes(fontDescriptorAttributes)
    return fontDescriptor
  }
}
