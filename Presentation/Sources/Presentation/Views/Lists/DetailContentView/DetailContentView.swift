//
//  DetailContentView.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/24/25.
//

import UIKit
import AppDesignSystem
import SnapKit

class DetailContentView: UIView, UIContentView {
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
    imageView.isUserInteractionEnabled = true
    return imageView
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .body1
    label.textColor = UIColor[.text1]
    return label
  }()

  init(withConfiguration conf: DetailContentConfiguration) {
    configuration = conf
    super.init(frame: .zero)
    setup()
    configure(configuration: conf)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    addSubview(wrapperView)
    wrapperView.addSubview(imageView)
    wrapperView.addSubview(titleLabel)

    layout()
  }

  private func configure(configuration: UIContentConfiguration) {
    guard let config = configuration as? DetailContentConfiguration else {
      return
    }

    titleLabel.text = config.title

    guard let imageUrl = URL(string: config.image) else {
      return
    }

    imageView.set(source: .remote(url: imageUrl))
  }

  private func layout() {
    wrapperView.snp.remakeConstraints { make in
      make.edges.equalToSuperview()
    }

    imageView.snp.remakeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(500.0.scaledWidth)
    }

    titleLabel.snp.remakeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(CGFloat.spacing8.scaledWidth)
      make.leading.trailing.equalToSuperview()
    }
  }
}
