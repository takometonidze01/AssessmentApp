//
//  ColorProvider.swift
//  AppDesignSystem
//
//  Created by Tako Metonidze on 3/21/25.
//

import UIKit.UIColor

final class ColorProvider {
  /// Singleton instance of `ColorProvider`
  nonisolated(unsafe) static let shared = ColorProvider()

  /// Cached dynamic colors
  private var dynamicColors: [DynamicColorType: [Int: UIColor]] = [:]

  /// Cached static colors
  private var staticColors: [StaticColorType: UIColor] = [:]

  /// Range of available dynamic font versions
  private var range = 1...7

  private init() {
    cacheStaticColors()
    cacheDynamicColors()
  }

  subscript(colorType: DynamicColorType, version: Int = 1) -> UIColor {
    guard range ~= version else {
      return dynamicColors[colorType]![1]!
    }
    return dynamicColors[colorType]![version]!
  }

  subscript(colorType: StaticColorType) -> UIColor {
    return staticColors[colorType]!
  }

  /// Cache all dybamic colors
  private func cacheDynamicColors() {
    for colorType in DynamicColorType.allCases {
      dynamicColors[colorType] = [:]
      for i in range {
        dynamicColors[colorType]![i] = colorType.version(i)
      }
    }
  }

  /// Cache all static colors
  private func cacheStaticColors() {
    for colorType in StaticColorType.allCases {
      staticColors[colorType] = colorType.asColor
    }
  }
}
