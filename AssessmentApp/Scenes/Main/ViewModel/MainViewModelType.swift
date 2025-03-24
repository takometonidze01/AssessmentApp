//
//  MainViewModelType.swift
//  AssessmentApp
//
//  Created by Tako Metonidze on 3/23/25.
//

import UIKit
import RxCocoa
import Presentation

@MainActor
extension MainView {
  enum ViewActions {
    case idle
  }
}

/// Protocol for MainViewModel setters
@MainActor
protocol MainViewModelInputs {
  func viewDidLoad()
  func setCollectionView(collectionView: CustomCollectionView)
}

/// Protocol for MainViewModelTypeViewModel getters
@MainActor
protocol MainViewModelOutputs {
  var actions: Driver<MainView.ViewActions> { get }
}

@MainActor
protocol MainViewModelType {
  /// inputs are used to give data to view model
  var inputs: MainViewModelInputs { get }
  /// getters are used to recieve data from view model
  var outputs: MainViewModelOutputs { get }
}

@MainActor
extension MainViewModel: MainViewModelType {
  var inputs: MainViewModelInputs { return self }
  var outputs: MainViewModelOutputs { return self }
}
