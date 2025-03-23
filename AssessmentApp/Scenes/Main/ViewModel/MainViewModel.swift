//
//  MainViewModel.swift
//  AssessmentApp
//
//  Created by Tako Metonidze on 3/23/25.
//

import RxSwift
import RxCocoa
import UIKit

@MainActor
final class MainViewModel: MainViewModelInputs, MainViewModelOutputs {
  let actions: Driver<MainView.ViewActions>
  
  private let actionsSubject: PublishSubject<MainView.ViewActions> = PublishSubject<MainView.ViewActions>()

  init() {
    actions = actionsSubject
      .asDriver(onErrorJustReturn: .idle)
  }

  func viewDidLoad() { }
}
