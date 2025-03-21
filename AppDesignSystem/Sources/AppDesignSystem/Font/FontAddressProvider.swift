//
//  FontAddressProvider.swift
//  AppDesignSystem
//
//  Created by Tako Metonidze on 3/21/25.
//

import Foundation

public final class FontAddressProvider {
  public init() {}

  public func callAsFunction() -> URL? {
    return Bundle.module.url(
      forResource: FontFamily.poppins.fontFiles.first,
      withExtension: nil
    )?.deletingLastPathComponent()
  }
}
