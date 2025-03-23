//
//  MainView.swift
//  AssessmentApp
//
//  Created by Tako Metonidze on 3/23/25.
//

import RxSwift
import UIKit

class MainView: UIView {
  private var disposeBag = DisposeBag()

  var viewModel: MainViewModelType

  // MARK: - Init

  init(viewModel: MainViewModelType) {
    self.viewModel = viewModel
    super.init(frame: .zero)
    setup()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private Implementations

  private func didReceive(newAction action: ViewActions) {
    switch action {
    case .idle:
      break
    }
  }

  private func setup() {
    layout()
    bind()
  }

  private func layout() { }

  private func bind() {
    disposeBag = DisposeBag()
    viewModel.outputs.actions
      .drive(with: self, onNext: { owner, action in
        owner.didReceive(newAction: action)
      })
      .disposed(by: disposeBag)
  }
}
