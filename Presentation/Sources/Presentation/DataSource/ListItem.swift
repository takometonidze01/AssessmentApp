//
//  ListItem.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/21/25.
//

import Foundation

public struct ListItem<SectionIdentifierType: Hashable & Sendable>: ListItemProvidable, Sendable {
  public typealias SectionIdentifierType = SectionIdentifierType

  public let id: String
  public let sectionIdentifier: SectionIdentifierType
  public let type: ListItemType

  public init(id: String, sectionIdentifier: SectionIdentifierType, type: ListItemType) {
    self.id = id
    self.sectionIdentifier = sectionIdentifier
    self.type = type
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id.hashValue)
    hasher.combine(sectionIdentifier.hashValue)
    hasher.combine(type.hashValue)
  }

  public static func == (lhs: ListItem, rhs: ListItem) -> Bool {
    return lhs.sectionIdentifier.hashValue == rhs.sectionIdentifier.hashValue
    && lhs.type == rhs.type
    && lhs.id == rhs.id
  }
}
