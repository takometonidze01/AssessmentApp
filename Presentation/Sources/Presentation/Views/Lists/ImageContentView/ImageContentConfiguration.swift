//
//  ImageContentConfiguration.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/24/25.
//

import UIKit

public struct ImageContentConfiguration: UIContentConfiguration {
  public typealias DidTapOnView = (() -> Void)

  public let image: String
  public let title: String
  public var didTapOnView: DidTapOnView?

  public init(
    image: String,
    title: String,
    didTapOnView: DidTapOnView?
  ) {
    self.image = image
    self.title = title
    self.didTapOnView = didTapOnView
  }

  public func makeContentView() -> UIView & UIContentView {
    ImageContentView(withConfiguration: self)
  }

  public func updated(for state: UIConfigurationState) -> ImageContentConfiguration {
    self
  }
}
