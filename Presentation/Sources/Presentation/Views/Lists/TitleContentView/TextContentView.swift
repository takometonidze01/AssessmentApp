//
//  TitleContentView.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/24/25.
//

import UIKit
import AppDesignSystem
import SnapKit

class TextContentView: UIView, UIContentView {
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

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor[.text1]
    return label
  }()

  init(withConfiguration conf: TextContentConfiguration) {
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
    wrapperView.addSubview(titleLabel)

    layout()
  }

  private func configure(configuration: UIContentConfiguration) {
    guard let config = configuration as? TextContentConfiguration else {
      return
    }

    titleLabel.text = config.title
    titleLabel.font = config.font
  }

  private func layout() {
    wrapperView.snp.remakeConstraints { make in
      make.edges.equalToSuperview()
    }

    titleLabel.snp.remakeConstraints { make in
      make.leading.equalToSuperview()
      make.centerY.equalToSuperview()
    }
  }
}
