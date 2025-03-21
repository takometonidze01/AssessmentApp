//
//  AppDesignSystem+Double.swift
//  AppDesignSystem
//
//  Created by Tako Metonidze on 3/21/25.
//

import Foundation

public extension Double {
  /// Add width scale factor to self
  var scaledWidth: Double {
    return (self * Constants.Screen.factor).rounded(.toNearestOrAwayFromZero)
  }

  /// Add height scale factor to self
  var scaledHeight: Double {
    return self * Constants.Screen.heightFactor
  }
}
