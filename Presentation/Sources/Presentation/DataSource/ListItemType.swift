//
//  ListItemType.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/21/25.
//

import Foundation

public enum ListItemType: String, Hashable, CaseIterable, Sendable {
  case page
  case sectionTitle
  case subtitle
  case imageItem
  case empty
  case error
}
