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
  func fetchFormData(resetCache: Bool) async throws -> PageItem
}

public final class FormRepository: FormRepositoring {
  private let service: CustomRestApi

  public init(service: CustomRestApi) {
    self.service = service
  }

  public func fetchFormData(resetCache: Bool) async throws -> PageItem {
    let target = FormService.getFormData
    let data: PageItem = try await service.request(target)

    let localData = LocalCacheData<PageItem>(data: data, expiresAt: Date.now + 60.0 * 60.0)
    await storeLocally(data: localData)
    return try await service.request(target)
  }

  private func storeLocally(data: LocalCacheData<PageItem>) async {
    let dataManager = ServicesCacheDataManager()
    await dataManager.saveDataToCache(data)
  }
}
