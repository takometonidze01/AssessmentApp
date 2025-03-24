//
//  EmptyStateContentView.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/24/25.
//

import UIKit
import AppDesignSystem
import SnapKit

class EmptyStateContentView: UIView, UIContentView {
  var configuration: UIContentConfiguration {
    didSet {
      configure(configuration: configuration)
    }
  }

  private lazy var wrapperView: UIView = {
    let view = UIView(frame: .zero)
    view.backgroundColor = .clear
    return view
  }()

  private lazy var imageView: CustomImageView = {
    let imageView = CustomImageView(frame: .zero)
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .body2
    label.textColor = UIColor[.text1]
    return label
  }()

  init(withConfiguration conf: EmptyStateContentConfiguration) {
    configuration = conf
    super.init(frame: .zero)
    setup()
    configure(configuration: conf)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    imageView.makeRoundedCorners(.allCorners, withRadius: .cornerRadius1)
  }

  private func setup() {
    addSubview(wrapperView)
    wrapperView.addSubview(imageView)
    wrapperView.addSubview(titleLabel)

    layout()
  }

  private func configure(configuration: UIContentConfiguration) {
    guard let config = configuration as? EmptyStateContentConfiguration else {
      return
    }

    switch config.type {
    case .error:
      titleLabel.text = "Error occurred"
      imageView.image = UIImage(image: .errorIcon)
    case .empty:
      titleLabel.text = "No Data Available"
      imageView.image = UIImage(image: .emptyIcon)
    }
  }

  private func layout() {
    wrapperView.snp.remakeConstraints { make in
      make.edges.equalToSuperview()
      make.height.equalTo(180.0.scaledWidth)
    }

    imageView.snp.remakeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(CGFloat.spacing1.scaledWidth)
      make.height.equalTo(400.0.scaledWidth)
      make.width.equalTo(300.0.scaledWidth)
    }

    titleLabel.snp.remakeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(CGFloat.spacing8.scaledWidth)
      make.centerX.equalToSuperview()
    }
  }
}
