//
//  FontDescription.swift
//  AppDesignSystem
//
//  Created by Tako Metonidze on 3/21/25.
//

import UIKit.UIFont

struct FontDescription {
  /// Font family of font
  let font: FontFamily

  /// Font Size
  let size: CGFloat

  /// Font weight
  let weight: UIFont.Weight

  /// Font style
  let style: UIFont.TextStyle

  /// Italic or not
  let italic: Bool

  /// Main initializer
  /// - Parameters:
  ///   - font: `FontFamily` to use
  ///   - size: `CGFloat` size of font
  ///   - style: `UIFont.TextStyle` style of font
  ///   - weight: `UIFont.Weight` weight of font
  ///   - italic: `Boold` italic or not
  init(font: FontFamily, size: CGFloat, style: UIFont.TextStyle, weight: UIFont.Weight = .regular, italic: Bool = false) {
    self.font = font
    self.size = size
    self.weight = weight
    self.style = style
    self.italic = italic
  }
}
