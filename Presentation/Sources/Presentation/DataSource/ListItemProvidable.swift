//
//  ListItemProvidable.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/21/25.
//

import Foundation

public protocol ListItemProvidable: Hashable, Identifiable {
  associatedtype SectionIdentifierType: Hashable & Sendable

  var type: ListItemType { get }

  init(id: String, sectionIdentifier: SectionIdentifierType, type: ListItemType)
}
