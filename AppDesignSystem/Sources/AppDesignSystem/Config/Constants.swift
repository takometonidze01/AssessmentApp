//
//  Constants.swift
//  AppDesignSystem
//
//  Created by Tako Metonidze on 3/21/25.
//

import UIKit

public struct Constants {
  public struct Screen {
    nonisolated(unsafe) static var factor: CGFloat = 1.0
    nonisolated(unsafe) static var heightFactor: CGFloat = 1.0
    nonisolated(unsafe) static var height: CGFloat = 0.0
    nonisolated(unsafe) static var width: CGFloat = 0.0

    @MainActor
    public static func initialize() {
      let bounds = UIScreen.main.bounds
      factor = bounds.width / 430.0
      heightFactor = bounds.height / 932.0
      width = bounds.width
      height = bounds.height
    }
  }
}

