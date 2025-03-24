//
//  Presentation+UIApplication.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/21/25.
//

import UIKit

public extension UIApplication {
  var mainWindow: UIWindow? {
    return UIApplication
      .shared
      .connectedScenes
      .compactMap { ($0 as? UIWindowScene)?.keyWindow }
      .first
  }
}

