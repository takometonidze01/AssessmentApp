//
//  ImageQuestion.swift
//  Domain
//
//  Created by Tako Metonidze on 3/23/25.
//

import Foundation

public struct ImageQuestion: Codable, Sendable {
  public let type: FormItemType
  public let src: String
  public let title: String
}
