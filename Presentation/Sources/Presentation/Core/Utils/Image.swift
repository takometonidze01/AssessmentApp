//
//  Image.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/24/25.
//

import UIKit.UIImage
import SwiftUI

public enum Image: String, CaseIterable, Codable, ImageRepresentable {
  static let assetsLibraryPath = "Images/"

  case transparentImagePlaceholder = "transparent-image-placeholder"

  public func asImage() -> UIImage? {
    return UIImage(image: self)
  }

  public func asImage(with tintColor: UIColor?) -> UIImage? {
    guard let tintColor else {
      return UIImage(image: self)
    }
    return UIImage(image: self).withTintColor(tintColor)
  }

  public func resized(to target: CGSize) -> UIImage? {
    return asImage()?.resized(to: target)
  }
}

public protocol ImageRepresentable: Sendable {
  func asImage() -> UIImage?
  func asImage(with tintColor: UIColor?) -> UIImage?
}

public extension Image {
  enum System: String, CaseIterable, Codable, ImageRepresentable {
    case close = "xmark"
    case chevronRight = "chevron.right"

    public func asImage() -> UIImage? {
      return UIImage(systemImage: self)
    }

    public func asImage(with tintColor: UIColor?) -> UIImage? {
      guard let tintColor else {
        return UIImage(systemImage: self)
      }
      return UIImage(systemImage: self)?.withTintColor(tintColor)
    }
  }
}

public extension UIImage {
  convenience init(image: Image) {
    self.init(named: "\(Image.assetsLibraryPath)/\(image.rawValue)", in: .module, with: nil)!
  }

  convenience init?(systemImage: Image.System, withConfiguration configuration: UIImage.SymbolConfiguration? = nil) {
    self.init(systemName: systemImage.rawValue, withConfiguration: configuration)
  }

  fileprivate func resized(to target: CGSize) -> UIImage {
    let ratio = min(
      target.height / size.height, target.width / size.width
    )
    let new = CGSize(
      width: size.width * ratio, height: size.height * ratio
    )
    let renderer = UIGraphicsImageRenderer(size: new)
    return renderer.image { _ in
      self.draw(in: CGRect(origin: .zero, size: new))
    }
  }
}

public extension SwiftUI.Image {
  init(image: Presentation.Image) {
    self.init("\(Presentation.Image.assetsLibraryPath)\(image.rawValue)", bundle: .module)
  }

  init?(systemImage: Presentation.Image.System) {
    self.init(systemName: systemImage.rawValue)
  }
}
