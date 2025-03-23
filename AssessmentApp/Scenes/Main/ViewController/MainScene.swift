//
//  MainScene.swift
//  AssessmentApp
//
//  Created by Tako Metonidze on 3/23/25.
//

import UIKit

class MainScene: UIViewController {
  private let viewModel: MainViewModelType

  // MARK: Lifecycle

  init(viewModel: MainViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    super.loadView()
    view = MainView(viewModel: viewModel)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.inputs.viewDidLoad()
  }
}
