//
//  Presentation+Color.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/21/25.
//

import SwiftUI
import UIKit

public extension Color {
  init(hex: String) {
    self.init(uiColor: UIColor(hex: hex))
  }

  init(hex: String, alpha: CGFloat = 1.0) {
    self.init(uiColor: UIColor(hex: hex, alpha: alpha))
  }
}
