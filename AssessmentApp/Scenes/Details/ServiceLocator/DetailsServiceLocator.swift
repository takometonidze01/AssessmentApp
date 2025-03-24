//
//  DetailsServiceLocator.swift
//  AssessmentApp
//
//  Created by Tako Metonidze on 3/24/25.
//

import Domain
import Factory
import XCoordinator

protocol DetailsServiceLocatorProtocol: Sendable {
  var formRepository: FormRepositoring { get }
}

final class DetailsServiceLocator: DetailsServiceLocatorProtocol {
  var formRepository: FormRepositoring {
    MainFlowContainer.shared.mainRepository()
  }
}
