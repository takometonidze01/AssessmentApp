//
//  CustomToastView.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/21/25.
//

import UIKit
import Toast
import DesignSystem

public class CustomToastView: UIStackView {
  private lazy var vStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 2
    stackView.alignment = .center

    return stackView
  }()

  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    NSLayoutConstraint.activate([
      imageView.widthAnchor.constraint(equalToConstant: 28),
      imageView.heightAnchor.constraint(equalToConstant: 28)
    ])

    return imageView
  }()

  private lazy var titleLabel: UILabel = {
    let view = UILabel()
    view.numberOfLines = 0
    return view
  }()

  private lazy var subtitleLabel: UILabel = {
    let view = UILabel()
    view.numberOfLines = 0
    return view
  }()

  public static var defaultImageTint: UIColor {
    return .black
  }

  public init(
    image: UIImage,
    imageTint: UIColor? = defaultImageTint,
    title: NSAttributedString,
    subtitle: NSAttributedString? = nil
  ) {
    super.init(frame: CGRect.zero)
    commonInit()

    self.titleLabel.attributedText = title
    self.vStack.addArrangedSubview(self.titleLabel)

    if let subtitle = subtitle {
      self.subtitleLabel.attributedText = subtitle
      self.vStack.addArrangedSubview(self.subtitleLabel)
    }

    self.imageView.image = image
    self.imageView.tintColor = imageTint

    addArrangedSubview(self.imageView)
    addArrangedSubview(self.vStack)
  }

  public init(image: UIImage, imageTint: UIColor? = defaultImageTint, title: String, subtitle: String? = nil) {
    super.init(frame: CGRect.zero)
    commonInit()

    self.titleLabel.text = title
    self.titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
    self.vStack.addArrangedSubview(self.titleLabel)

    if let subtitle = subtitle {
      self.subtitleLabel.textColor = .systemGray
      self.subtitleLabel.text = subtitle
      self.subtitleLabel.font = .systemFont(ofSize: 12, weight: .bold)
      self.vStack.addArrangedSubview(self.subtitleLabel)
    }

    self.imageView.image = image
    self.imageView.tintColor = imageTint

    addArrangedSubview(self.imageView)
    addArrangedSubview(self.vStack)
  }

  @available(*, unavailable)
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func commonInit() {
    axis = .horizontal
    spacing = 15
    alignment = .center
    distribution = .fill
  }
}
