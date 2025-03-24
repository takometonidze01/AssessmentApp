//
//  FormItem.swift
//  Domain
//
//  Created by Tako Metonidze on 3/23/25.
//

import Foundation

public enum FormItem: Decodable, Sendable {
  case page(PageItem)
  case section(SectionItem)
  case text(TextQuestion)
  case image(ImageQuestion)

  public enum CodingKeys: String, CodingKey {
    case type
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let type = try container.decode(FormItemType.self, forKey: .type)

    switch type {
    case .page:
      self = .page(try PageItem(from: decoder))
    case .section:
      self = .section(try SectionItem(from: decoder))
    case .text:
      self = .text(try TextQuestion(from: decoder))
    case .image:
      self = .image(try ImageQuestion(from: decoder))
    }
  }
}
