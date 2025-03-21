//
//  ListSection.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/21/25.
//

import Foundation

public struct ListSection<T: Hashable & Sendable>: ListSectionProvidable, Sendable {
  public enum SectionType: Equatable, Sendable {
    case regular
    case paginationActivityIndicator
  }

  public let id: T
  public let title: String
  public let type: SectionType

  public init(id: T, title: String, type: SectionType = .regular ) {
    self.id = id
    self.title = title
    self.type = type
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(self.id)
    hasher.combine(self.title)
    hasher.combine(self.type)
  }

  public static func == (lhs: ListSection, rhs: ListSection) -> Bool {
    return lhs.id.hashValue == rhs.id.hashValue && lhs.title == rhs.title && lhs.type == rhs.type
  }
}
