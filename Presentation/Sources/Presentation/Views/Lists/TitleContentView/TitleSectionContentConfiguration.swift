//
//  TitleContentConfiguration.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/24/25.
//

import UIKit

public struct TitleSectionContentConfiguration: UIContentConfiguration {
  public let title: String

  public init(title: String) {
    self.title = title
  }

  public func makeContentView() -> UIView & UIContentView {
    TitleSectionContentView(withConfiguration: self)
  }

  public func updated(for state: UIConfigurationState) -> TitleSectionContentConfiguration {
    self
  }
}
