//
//  MainServiceLocator.swift
//  AssessmentApp
//
//  Created by Tako Metonidze on 3/24/25.
//

import Domain
import Factory
import XCoordinator
import Presentation

protocol MainServiceLocatorProtocol: Sendable {
  @MainActor var unownedMainCoordinator: UnownedRouter<MainRoute> { get }

  var formRepository: FormRepositoring { get }

  @MainActor var toast: CustomToast { get }
}

final class MainServiceLocator: MainServiceLocatorProtocol {
  @MainActor var unownedMainCoordinator: UnownedRouter<MainRoute> {
    MainFlowContainer.shared.mainCoordinatorUnowned()
  }

  var formRepository: FormRepositoring {
    MainFlowContainer.shared.mainRepository()
  }

  @MainActor var toast: CustomToast {
    MainFlowContainer.shared.toast()
  }
}
