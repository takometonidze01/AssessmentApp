//
//  CustomToastView.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/21/25.
//

import UIKit
import Toast
import AppDesignSystem

public class CustomToastView: UIStackView {
  private var configuration: CustomToastViewConfiguration

  private lazy var wrapperView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor[.toastBackground]
    return view
  }()

  private lazy var icon: CustomImageView = {
    var view = CustomImageView(frame: .zero)
    view.contentMode = .scaleAspectFit
    return view
  }()

  private lazy var titleLabel: UILabel = {
    var view = UILabel(frame: .zero)
    view.font = .body1
    view.textColor = UIColor[.toastTextColor]
    view.numberOfLines = 0
    return view
  }()

  private lazy var descriptionLabel: UILabel = {
    var view = UILabel(frame: .zero)
    view.font = .body2
    view.textColor = UIColor[.toastTextColor]
    view.numberOfLines = 0
    return view
  }()

  public init(with config: CustomToastViewConfiguration) {
    configuration = config
    super.init(frame: .zero)
    setup()
    layout()
    configure()
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
    apply(cornerRadius: .fixed(corners: .allCorners, value: 24.0))
  }

  private func setup() {
    addSubview(wrapperView)
    wrapperView.addSubview(icon)
    wrapperView.addSubview(titleLabel)
    wrapperView.addSubview(descriptionLabel)
  }

  private func layout() {
    wrapperView.snp.remakeConstraints { make in
      make.edges.equalToSuperview()
    }

    if configuration.description != nil {
      descriptionLabel.snp.remakeConstraints { make in
        make.top.equalTo(titleLabel.snp.bottom)
        make.leading.equalTo(titleLabel.snp.leading)
        make.trailing.equalTo(titleLabel.snp.trailing)
        make.bottom.equalToSuperview().offset(-CGFloat.spacing7.scaledWidth)
      }

      titleLabel.snp.remakeConstraints { make in
        make.top.equalToSuperview().offset(CGFloat.spacing7.scaledWidth)
        make.leading.equalTo(icon.snp.trailing).offset(CGFloat.spacing7.scaledWidth)
        make.trailing.equalToSuperview().offset(-CGFloat.spacing7.scaledWidth)
        make.height.equalTo(23.0.scaledWidth)
      }
    } else {
      titleLabel.snp.remakeConstraints { make in
        make.top.equalToSuperview().offset(CGFloat.spacing7.scaledWidth)
        make.leading.equalTo(icon.snp.trailing).offset(CGFloat.spacing7.scaledWidth)
        make.trailing.equalToSuperview().offset(-CGFloat.spacing7.scaledWidth)
        make.bottom.equalToSuperview().offset(-CGFloat.spacing7.scaledWidth)
      }
    }

    icon.snp.remakeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().offset(CGFloat.spacing6.scaledWidth)
      make.size.equalTo(34.0.scaledWidth)
    }
  }

  private func configure() {
    titleLabel.text = configuration.title
    descriptionLabel.text = configuration.description
    descriptionLabel.isHidden = configuration.description == nil
    icon.set(source: .local(image: configuration.type.image))
    backgroundColor = .clear
  }
}
