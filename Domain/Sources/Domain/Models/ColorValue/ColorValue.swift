//
//  ColorValue.swift
//  Domain
//
//  Created by Tako Metonidze on 3/23/25.
//

import Foundation

public enum ColorValue: String {
  case light
  case dark
}

extension ColorValue: Codable { }
extension ColorValue: Sendable { }
