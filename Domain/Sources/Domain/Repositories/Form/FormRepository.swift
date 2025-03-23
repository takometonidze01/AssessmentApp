//
//  FormRepository.swift
//  Domain
//
//  Created by Tako Metonidze on 3/23/25.
//

import Networking
import UIKit

public protocol FormRepositoring: Sendable {
  /// fetch form data
  /// - Returns: PageItem
  func fetchFormData() async throws -> PageItem
}

public final class FormRepository: FormRepositoring {
  private let service: CustomRestApi

  public init(service: CustomRestApi) {
    self.service = service
  }

  public func fetchFormData() async throws -> PageItem {
    let target = FormService.getFormData
    return try await service.request(target)
  }
}
