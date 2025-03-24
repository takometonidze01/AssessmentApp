//
//  TitleContentConfiguration.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/24/25.
//

import UIKit

public struct TextContentConfiguration: UIContentConfiguration {
  public let title: String
  public let font: UIFont
  public let isBold: Bool
  public let hasBullet: Bool
  public let indentationLevel: Int

  public init(
    title: String,
    font: UIFont,
    isBold: Bool = false,
    hasBullet: Bool = false,
    indentationLevel: Int = 0
  ) {
    self.title = title
    self.font = font
    self.isBold = isBold
    self.hasBullet = hasBullet
    self.indentationLevel = indentationLevel
  }

  public func makeContentView() -> UIView & UIContentView {
    TextContentView(withConfiguration: self)
  }

  public func updated(for state: UIConfigurationState) -> TextContentConfiguration {
    self
  }
}
