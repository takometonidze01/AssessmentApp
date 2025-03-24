//
//  ImageContentConfiguration.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/24/25.
//

import UIKit

public struct ImageContentConfiguration: UIContentConfiguration {
  public let image: String
  public let title: String

  public init(
    image: String,
    title: String
  ) {
    self.image = image
    self.title = title
  }

  public func makeContentView() -> UIView & UIContentView {
    ImageContentView(withConfiguration: self)
  }

  public func updated(for state: UIConfigurationState) -> ImageContentConfiguration {
    self
  }
}
