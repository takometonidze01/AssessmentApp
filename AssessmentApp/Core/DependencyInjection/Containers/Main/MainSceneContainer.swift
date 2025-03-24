//
//  MainSceneContainer.swift
//  AssessmentApp
//
//  Created by Tako Metonidze on 3/24/25.
//

import Factory
import Domain

extension MainFlowContainer {
  @MainActor var mainScene: Factory<MainScene> {
    self { @MainActor in
      let serviceLocator = MainServiceLocator()
      let viewModel = MainViewModel(serviceLocator: serviceLocator)
      return MainScene(viewModel: viewModel)
    }
    .unique
  }

  @MainActor var detailsScene: ParameterFactory<
    ImageQuestion,
    DetailsScene
  > {
    self { @MainActor in
      let serviceLocator = DetailsServiceLocator()
      let viewModel = DetailsViewModel(
        imageData: $0,
        serviceLocator: serviceLocator
      )
      return DetailsScene()
    }
    .unique
  }
}
