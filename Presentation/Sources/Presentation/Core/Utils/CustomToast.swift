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

  public init(config: CustomToastConfiguration = .init()) {
    self.config = config
  }

  public func showCustomView(
    with viewConfig: CustomToastConfiguration
  ) {
    let view = CustomToastView(with: viewConfig)
    let attributes = createAttributeByConfig()

    Haptic(feedbackType: viewConfig.type.haptic).feedbackType.perform()
    SwiftEntryKit.display(entry: view, using: attributes)
  }

  public func showGenericError() {
    let viewConfig =  CustomToastConfiguration(title: "error_occurred".localized(.common), type: .error)
    let view = CustomToastView(with: viewConfig)
    let attributes = createAttributeByConfig()
    Haptic(feedbackType: viewConfig.type.haptic).feedbackType.perform()
    SwiftEntryKit.display(entry: view, using: attributes)
  }

  private func createAttributeByConfig() -> EKAttributes {
    let themeType = UIUserInterfaceStyle(rawValue: UserDefaults.standard[.darkTheme])

    var attributes = EKAttributes.topFloat
    attributes.entranceAnimation = config.entranceAnimation
    attributes.exitAnimation = config.exitAnimation
    attributes.entryBackground = config.background
    attributes.scroll = config.scroll
    attributes.popBehavior = config.popBehavior
    attributes.displayDuration = config.displayDuration
    attributes.screenBackground = config.screenBackground
    attributes.statusBar = themeType == .dark ? .light : .dark
    attributes.displayMode = themeType == .dark ? .dark : .light

    attributes.lifecycleEvents.willAppear = {
      SwiftEntryKit.window?.overrideUserInterfaceStyle = .light
    }

    return attributes
  }
}
