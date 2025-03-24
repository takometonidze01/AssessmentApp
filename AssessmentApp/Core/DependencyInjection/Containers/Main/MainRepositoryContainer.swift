//
//  File.swift
//  AssessmentApp
//
//  Created by Tako Metonidze on 3/24/25.
//

import Factory
import Domain
import Networking
import UIKit

extension MainFlowContainer {
  var tnetRestApi: Factory<CustomRestApi> {
    self {
      return CustomRestApi(
        baseURL: URL(string: "https://run.mocky.io") ?? URL(fileReferenceLiteralResourceName: "")
      )
    }
    .unique
  }

  var mainRepository: Factory<FormRepositoring> {
    self {
      FormLocalRepository(service: MainFlowContainer.shared.tnetRestApi())
    }
    .shared
  }
}
