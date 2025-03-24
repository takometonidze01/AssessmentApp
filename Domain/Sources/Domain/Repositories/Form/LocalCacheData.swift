//
//  LocalCacheData.swift
//  Domain
//
//  Created by Tako Metonidze on 3/24/25.
//

import Networking
import UIKit

public struct LocalCacheData<Element: Codable & Equatable & Sendable> {
  public let cachedItem: Element
  public let expiresAt: Date

  public var isExpired: Bool {
    expiresAt.timeIntervalSince1970 < Date.now.timeIntervalSince1970
  }

  public init(data: Element, expiresAt: Date) {
    self.cachedItem = data
    self.expiresAt = expiresAt
  }
}

extension LocalCacheData: Codable { }
extension LocalCacheData: Equatable { }
extension LocalCacheData: Sendable { }
