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

  public init(
    title: String,
    font: UIFont
  ) {
    self.title = title
    self.font = font
  }

  public func makeContentView() -> UIView & UIContentView {
    TextContentView(withConfiguration: self)
  }

  public func updated(for state: UIConfigurationState) -> TextContentConfiguration {
    self
  }
}
