//
//  ImageSource.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/24/25.
//

import UIKit

public enum ImageSource {
  case local(image: ImageRepresentable)
  case remote(url: URL)
  case image(image: UIImage?)
}

extension ImageSource: Sendable { }

public extension ImageSource {
  var isLocal: Bool {
    switch self {
    case .local: true
    default: false
    }
  }
}
