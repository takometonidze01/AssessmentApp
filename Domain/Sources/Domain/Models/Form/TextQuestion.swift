//
//  TextQuestion.swift
//  Domain
//
//  Created by Tako Metonidze on 3/23/25.
//

import Foundation

public struct TextQuestion: Decodable, Sendable {
  public let type: FormItemType
  public let title: String
}
