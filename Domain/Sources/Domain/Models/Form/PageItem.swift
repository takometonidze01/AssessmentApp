//
//  PageItem.swift
//  Domain
//
//  Created by Tako Metonidze on 3/23/25.
//

import Foundation

public struct PageItem: Decodable, Sendable {
  public let type: FormItemType
  public let title: String
  public let items: [FormItem]
}
