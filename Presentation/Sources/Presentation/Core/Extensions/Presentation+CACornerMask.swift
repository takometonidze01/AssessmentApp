//
//  Presentation+CACornerMask.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/21/25.
//

import UIKit

public extension CACornerMask {
  static let allCorners: Self = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
  static let onlyRightCorners: Self = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
  static let onlyLeftCorners: Self = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
  static let onlyTopCorners: Self = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
  static let onlyBottomCorners: Self = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
}
