//
//  FontProvider.swift
//  AppDesignSystem
//
//  Created by Tako Metonidze on 3/21/25.
//

import UIKit.UIFont

final class FontProvider {
  /// Shared instance of FontProvider
  nonisolated(unsafe) static let shared = FontProvider()

  /// Fonts cache
  private var fonts: [FontType: UIFont] = [:]

  /// Get font from cache
  /// - Parameter fontType: `FontType` of font
  /// - Returns: `UIFont` instance
  subscript(fontType: FontType) -> UIFont {
    return fonts[fontType] ?? FontType.body1.font
  }

  /// Get custom font with supported `FontFamily`
  func custom(_ fontFamily: FontFamily = .system, size: CGFloat, style: UIFont.TextStyle = .body, weight: UIFont.Weight = .regular, italic: Bool = false) -> UIFont {
    return FontType.custom(
      fontFamily,
      size: size,
      style: style,
      weight: weight,
      italic: italic
    ).font
  }

  /// Private initializer
  private init() {
    registerAllFonts()
    fonts = [
      FontType.h1: FontType.h1.font,
      FontType.button: FontType.button.font,
      FontType.body1: FontType.body1.font,
      FontType.body2: FontType.body2.font,
    ]
  }

  private func registerAllFonts() {
    FontFamily.poppins.fontFiles.forEach { fontFile in
      registerFont(fileName: fontFile)
    }
  }

  @discardableResult private func registerFont(fileName: String) -> Bool {
    guard let url = Bundle.module.url(forResource: fileName, withExtension: nil) else {
      return false
    }

    let fontError = UnsafeMutablePointer<Unmanaged<CFError>?>.allocate(capacity: 1)
    var registered = true

    if !CTFontManagerRegisterFontsForURL(url as CFURL, .process, fontError) {
      if let error = fontError.pointee?.takeRetainedValue() {
        print("*** FONT ERROR: \(error.localizedDescription)")
      }
      registered = false
    }
    fontError.deallocate()

    return registered
  }
}

#if DEBUG
extension FontProvider {
  func registerFontNameForTests(fileName: String) -> Bool {
    registerFont(fileName: fileName)
  }
}
#endif
