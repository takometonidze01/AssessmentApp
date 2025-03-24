//
//  DetailsViewModelType.swift
//  AssessmentApp
//
//  Created by Tako Metonidze on 3/24/25.
//

import UIKit
import RxCocoa
import Presentation

@MainActor
extension DetailsView {
  enum ViewActions {
    case idle
  }
}

/// Protocol for DetailsViewModel setters
@MainActor
protocol DetailsViewModelInputs {
  func setCollectionView(collectionView: CustomCollectionView)
}

/// Protocol for DetailsViewModel getters
@MainActor
protocol DetailsViewModelOutputs {
  var actions: Driver<DetailsView.ViewActions> { get }
}

@MainActor
protocol DetailsViewModelType {
  /// inputs are used to give data to view model
  var inputs: DetailsViewModelInputs { get }
  /// getters are used to recieve data from view model
  var outputs: DetailsViewModelOutputs { get }
}

@MainActor
extension DetailsViewModel: DetailsViewModelType {
  var inputs: DetailsViewModelInputs { return self }
  var outputs: DetailsViewModelOutputs { return self }
}
