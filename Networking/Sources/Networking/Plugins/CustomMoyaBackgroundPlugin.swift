//
//  CustomMoyaBackgroundPlugin.swift
//  Networking
//
//  Created by Tako Metonidze on 3/21/25.
//

import Foundation
import UIKit
import Moya

class CustomMoyaBackgroundPlugin: @preconcurrency PluginType {
  var bgTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
  var numInFlight = 0

  @MainActor
  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    guard let customTarget = target as? CustomTargetType, customTarget.mayRunAsBackgroundTask else {
      return request
    }

    if numInFlight == 0 {
      bgTask = UIApplication.shared.beginBackgroundTask(withName: "custom.moya.background.plugin") {
        if self.bgTask != UIBackgroundTaskIdentifier.invalid {
          UIApplication.shared.endBackgroundTask(self.bgTask)
          self.bgTask = .invalid
          self.numInFlight = 0
        }
      }
    }
    numInFlight+=1
    return request
  }

  @MainActor
  func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
    guard let customTarget = target as? CustomTargetType, customTarget.mayRunAsBackgroundTask else {
      return
    }

    numInFlight -= 1
    if numInFlight <= 0 {
      UIApplication.shared.endBackgroundTask(self.bgTask)
      self.bgTask = .invalid
    }
  }
}
