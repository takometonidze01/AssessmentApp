//
//  CustomImageView.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/24/25.
//

import UIKit
import Kingfisher

public final class CustomImageView: UIImageView {
  public enum ImageAnimation {
    case flipFromLeft
    case flipFromRight
    case fade

    func convert(withDuration duration: TimeInterval) -> ImageTransition {
      switch self {
      case .flipFromLeft:
        return ImageTransition.flipFromLeft(duration)
      case .flipFromRight:
        return ImageTransition.flipFromRight(duration)
      case .fade:
        return ImageTransition.fade(duration)
      }
    }
  }

  private var defaultPlaceholder: UIImage = UIImage(image: .transparentImagePlaceholder)

  public var onImageLoad: ( @MainActor (_ image: UIImage?) -> Void)?

  public override init(frame: CGRect) {
    super.init(frame: .zero)
    setup()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    contentMode = .scaleAspectFill
  }

  public func set(
    source: ImageSource,
    tintColor: UIColor? = nil,
    withPlaceholderImage placeholder: UIImage? = nil,
    additionalOptions: KingfisherOptionsInfo = []
  ) {
    reset(usePlaceholder: true)

    switch source {
    case .local(let localImage):
      image = localImage.asImage(with: tintColor)
    case .remote(let url):
      self.set(url: url, withPlaceholderImage: placeholder, additionalOptions: additionalOptions)
    case .image(let img):
      image = img
    }
  }

  private func set(url: URL, withPlaceholderImage placeholder: UIImage? = nil, animation: ImageAnimation = .fade, additionalOptions: KingfisherOptionsInfo = []) {
    let placeholderImage = placeholder ?? defaultPlaceholder
    let options: KingfisherOptionsInfo = [
      .transition(animation.convert(withDuration: 0.25))
    ] + additionalOptions

    let placeHolder = TNETImagePlaceHolder(withImage: placeholderImage)
    kf.setImage(with: url, placeholder: placeHolder, options: options, progressBlock: nil) { [weak self] result in
      guard let self, let callback = self.onImageLoad else {
        return
      }
      switch result {
      case .success(let data):
        callback(data.image)
      default:
        callback(nil)
      }
    }
  }

  func reset(usePlaceholder: Bool = false, placeholder: UIImage? = nil) {
    kf.cancelDownloadTask()
    image = nil
  }
}

final class TNETImagePlaceHolder: UIView, Kingfisher.Placeholder {
  private var placeholderImage: UIImage

  private lazy var placeHolderImageView: UIImageView = {
    let view = UIImageView(frame: .zero)
    view.contentMode = .scaleAspectFit
    return view
  }()

  public init(withImage image: UIImage = UIImage(image: .transparentImagePlaceholder)) {
    self.placeholderImage = image

    super.init(frame: .zero)

    setup()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    placeHolderImageView.image = placeholderImage
    addSubview(placeHolderImageView)
  }

  private func layout() {
    snp.remakeConstraints { make in
      make.edges.equalToSuperview()
    }

    placeHolderImageView.snp.remakeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  public func add(to imageView: KFCrossPlatformImageView) {
    imageView.addSubview(self)
    layout()
  }

  /// How the placeholder should be removed from a given image view.
  public func remove(from imageView: KFCrossPlatformImageView) {
    removeFromSuperview()
  }
}
