//
//  CustomToast.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/21/25.
//

import Foundation
import UIKit
import SwiftEntryKit

public struct CustomToastConfiguration {
  let position: EKAttributes.Position
  let entranceAnimation: EKAttributes.Animation
  let exitAnimation: EKAttributes.Animation
  let background: EKAttributes.BackgroundStyle
  let scroll: EKAttributes.Scroll
  let popBehavior: EKAttributes.PopBehavior
  let displayDuration: TimeInterval
  let screenBackground: EKAttributes.BackgroundStyle

  public init(
    position: EKAttributes.Position = .top,
    entranceAnimation: EKAttributes.Animation = .translation,
    exitAnimation: EKAttributes.Animation = .translation,
    background: EKAttributes.BackgroundStyle = .clear,
    scroll: EKAttributes.Scroll = .edgeCrossingDisabled(swipeable: true),
    popBehavior: EKAttributes.PopBehavior = .animated(
      animation: .init(
        translate: .init(
          duration: 0.3,
          anchorPosition: .top
        )
      )
    ),
    displayDuration: TimeInterval = 2,
    screenBackground: EKAttributes.BackgroundStyle = .clear
  ) {
    self.position = position
    self.entranceAnimation = entranceAnimation
    self.exitAnimation = exitAnimation
    self.background = background
    self.scroll = scroll
    self.popBehavior = popBehavior
    self.displayDuration = displayDuration
    self.screenBackground = screenBackground
  }
}

@MainActor
public class CustomToast {
  var config: CustomToastConfiguration

  var isDarkMode = UITraitCollection.current.userInterfaceStyle == .dark

  public init(config: CustomToastConfiguration = .init()) {
    self.config = config
  }

  public func showCustomView(
    with viewConfig: CustomToastViewConfiguration
  ) {
    let view = CustomToastView(with: viewConfig)
    let attributes = createAttributeByConfig()

    SwiftEntryKit.display(entry: view, using: attributes)
  }

  public func showGenericError() {
    let viewConfig =  CustomToastViewConfiguration(title: "Error occurred", type: .error)
    let view = CustomToastView(with: viewConfig)
    let attributes = createAttributeByConfig()
    SwiftEntryKit.display(entry: view, using: attributes)
  }

  private func createAttributeByConfig() -> EKAttributes {
    var attributes = EKAttributes.topFloat
    attributes.entranceAnimation = config.entranceAnimation
    attributes.exitAnimation = config.exitAnimation
    attributes.entryBackground = config.background
    attributes.scroll = config.scroll
    attributes.popBehavior = config.popBehavior
    attributes.displayDuration = config.displayDuration
    attributes.screenBackground = config.screenBackground
    attributes.statusBar = isDarkMode ? .light : .dark
    attributes.displayMode = isDarkMode ? .dark : .light

    attributes.lifecycleEvents.willAppear = {
      SwiftEntryKit.window?.overrideUserInterfaceStyle = .light
    }

    return attributes
  }
}
