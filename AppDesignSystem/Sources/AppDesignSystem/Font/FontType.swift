//
//  FontType.swift
//  AppDesignSystem
//
//  Created by Tako Metonidze on 3/21/25.
//

import UIKit.UIFont

enum FontType: Equatable, Hashable {
  /// Used for generating custom font
  /// - Parameter size: `CGFloat` size of font
  /// - Parameter style: `UIFont.TextStyle` style of font. default is `.body`
  /// - Parameter weight: `UIFont.Weight` weight of fond. default is `.regular`
  /// - Parameter italic: `Bool` make font italic or not. default is `false`
  case custom(_ fontFamily: FontFamily = .system, size: CGFloat, style: UIFont.TextStyle = .body, weight: UIFont.Weight = .regular, italic: Bool = false)
  case h1
  case button
  case body1
  case body2


  private var fontDescription: FontDescription {
    switch self {
    case .custom(let family, let size, let style, let weight, let italic):
      return FontDescription(font: family, size: size, style: style, weight: weight, italic: italic)
    case .h1:
      return FontDescription(font: .poppins, size: 20, style: .title1, weight: .semibold)
    case .button:
      return FontDescription(font: .poppins, size: 12, style: .body, weight: .regular)
    case .body1:
      return FontDescription(font: .poppins, size: 16, style: .body, weight: .regular)
    case .body2:
      return FontDescription(font: .poppins, size: 14, style: .body, weight: .regular)
    }
  }

  var font: UIFont {
    let fontSize = fontDescription.size.scaledWidth
    var descriptor: UIFontDescriptor
    var traits: [UIFontDescriptor.TraitKey: Any] = [
      UIFontDescriptor.TraitKey.weight: fontDescription.weight
    ]

    if fontDescription.italic {
      traits[UIFontDescriptor.TraitKey.symbolic] = UIFontDescriptor.SymbolicTraits.traitItalic.rawValue
    }

    if fontDescription.font == .system {
      descriptor = UIFont.systemFont(ofSize: fontSize, weight: fontDescription.weight).fontDescriptor
    } else {
      descriptor = UIFontDescriptor(fontAttributes: [
        .family: fontDescription.font.name
      ])
    }

    descriptor = descriptor.addingAttributes([
      .traits: traits
    ])

    let font = UIFont(descriptor: descriptor, size: fontSize)
    let fontMetrics = UIFontMetrics(forTextStyle: fontDescription.style)
    return fontMetrics.scaledFont(for: font, maximumPointSize: fontSize)
  }
}
