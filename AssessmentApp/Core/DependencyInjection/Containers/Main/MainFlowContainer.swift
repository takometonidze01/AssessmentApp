//
//  MainFlowContainer.swift
//  AssessmentApp
//
//  Created by Tako Metonidze on 3/24/25.
//

import Factory
import Presentation
import XCoordinator

final class MainFlowContainer: SharedContainer {
  static let shared = MainFlowContainer()
  let manager = ContainerManager()
}

// MARK: Coordinator
extension MainFlowContainer {
  @MainActor var mainCoordinator: ParameterFactory<NavigationCoordinator<MainRoute>.RootViewController, MainCoordinator> {
    self { @MainActor in
      let serviceLocator = MainCoordinatorServiceLocator()
      return MainCoordinator(rootViewController: $0, serviceLocator: serviceLocator)
    }
    .shared
  }

  @MainActor var mainCoordinatorUnowned: Factory<
    UnownedRouter<MainRoute>
  > {
    self { @MainActor in
      let coordinator = MainFlowContainer.shared.mainCoordinator(.init())
      return coordinator.unownedRouter
    }
    .shared
  }
}
