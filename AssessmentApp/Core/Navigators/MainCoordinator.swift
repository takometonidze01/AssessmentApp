//
//  MainCoordinator.swift
//  AssessmentApp
//
//  Created by Tako Metonidze on 3/24/25.
//

@preconcurrency import XCoordinator
import Presentation
import UIKit
import Domain

enum MainRoute: Route, @unchecked Sendable {
  case main
  case details(imageData: ImageQuestion)
}

class MainCoordinator: NavigationCoordinator<MainRoute>, @unchecked Sendable {
  private var serviceLocator: MainCoordinatorServiceLocatorProtocol

  public init(
    rootViewController: RootViewController,
    initialRoute: RouteType? = nil,
    serviceLocator: MainCoordinatorServiceLocatorProtocol
  ) {
    self.serviceLocator = serviceLocator
    super.init(rootViewController: rootViewController, initialRoute: initialRoute)
  }

  deinit {
    print("⬅️🗑 deinit \(String(describing: type(of: self)))")
  }

  //swiftlint:disable function_body_length
  override func prepareTransition(for route: MainRoute) -> NavigationTransition {
    MainActor.assumeIsolated {
      getTransition(for: route)
    }
  }

  @MainActor
  func getTransition(for route: MainRoute) -> NavigationTransition {
    switch route {
    case .main:
      let controller = makeViewController(for: route)
      return .set([controller])
    case .details:
      let controller = makeViewController(for: route)
//      controller.sheetPresentationController?.detents = UISheetPresentationController.detents(.large())
      return .present(controller)
    }
  }

  @MainActor
  func makeViewController(for route: MainRoute) -> UIViewController {
    switch route {
    case .main:
      return serviceLocator.mainScene()
    case .details(let imageQuestion):
      return serviceLocator.details(imageQuestion: imageQuestion)
    default:
      return UIViewController()
    }
  }
  //swiftlint:enable function_body_length
}
