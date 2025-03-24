//
//  FormItem.swift
//  Domain
//
//  Created by Tako Metonidze on 3/23/25.
//

import Foundation

public enum FormItem: Codable, Sendable {
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

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    switch self {
    case .page(let pageItem):
      try container.encode(FormItemType.page, forKey: .type)
      try pageItem.encode(to: encoder)

    case .section(let sectionItem):
      try container.encode(FormItemType.section, forKey: .type)
      try sectionItem.encode(to: encoder)

    case .text(let textQuestion):
      try container.encode(FormItemType.text, forKey: .type)
      try textQuestion.encode(to: encoder)

    case .image(let imageQuestion):
      try container.encode(FormItemType.image, forKey: .type)
      try imageQuestion.encode(to: encoder)
    }
  }
}
