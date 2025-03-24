//
//  DetailsScene.swift
//  AssessmentApp
//
//  Created by Tako Metonidze on 3/24/25.
//

import UIKit

class DetailsScene: UIViewController {
  private let viewModel: DetailsViewModelType

  // MARK: Lifecycle

  init(viewModel: DetailsViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    super.loadView()
    view = DetailsView(viewModel: viewModel)
  }
}
