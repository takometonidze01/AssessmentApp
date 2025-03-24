//
//  MainServiceLocator.swift
//  AssessmentApp
//
//  Created by Tako Metonidze on 3/24/25.
//

import Domain
import Networking

protocol MainCoordinatorServiceLocatorProtocol: Sendable {
  @MainActor
  func mainScene() -> MainScene

  @MainActor
  func details(imageQuestion: ImageQuestion) -> DetailsScene
}

/// MainServiceLocator Struct
struct MainCoordinatorServiceLocator: MainCoordinatorServiceLocatorProtocol {
  @MainActor
  func mainScene() -> MainScene {
    MainFlowContainer.shared.mainScene()
  }

  @MainActor
  func details(imageQuestion: ImageQuestion) -> DetailsScene {
    MainFlowContainer.shared.detailsScene(imageQuestion)
  }
}
