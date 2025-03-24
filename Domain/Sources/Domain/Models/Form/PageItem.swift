//
//  PageItem.swift
//  Domain
//
//  Created by Tako Metonidze on 3/23/25.
//

import Foundation

public struct PageItem: Codable, Sendable {
  public let type: FormItemType
  public let title: String
  public let items: [FormItem]
}

extension PageItem: Equatable {
  public static func == (lhs: PageItem, rhs: PageItem) -> Bool {
    return lhs.type == rhs.type
    && lhs.title == rhs.title
  }
}
