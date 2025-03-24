//
//  EmptyStateContentConfiguration.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/24/25.
//

import UIKit

public struct EmptyStateContentConfiguration: UIContentConfiguration {
  public let type: EmptyStateType

  public init(type: EmptyStateType) {
    self.type = type
  }

  public func makeContentView() -> UIView & UIContentView {
    EmptyStateContentView(withConfiguration: self)
  }

  public func updated(for state: UIConfigurationState) -> EmptyStateContentConfiguration {
    self
  }
}
