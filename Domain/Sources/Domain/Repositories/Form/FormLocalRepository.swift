//
//  FormLocalRepository.swift
//  Domain
//
//  Created by Tako Metonidze on 3/24/25.
//

import Networking
import UIKit

public final class FormLocalRepository: FormRepositoring {
  private let remoteRepo: FormRepository
  private let dataManager = ServicesCacheDataManager()

  public init(service: CustomRestApi) {
    self.remoteRepo = .init(service: service)
  }

  public func fetchFormData() async throws -> PageItem {
    var cachedData: LocalCacheData<PageItem>?
    do {
      cachedData = try await readCacheData()
    } catch {
      print("Error reading cache data:", error.localizedDescription)
    }

    if let cachedData = cachedData, !cachedData.cachedItem.items.isEmpty, !cachedData.isExpired {
      return cachedData.cachedItem
    } else {
      do {
        let remoteData = try await remoteRepo.fetchFormData()
        let localData = LocalCacheData<PageItem>(data: remoteData, expiresAt: Date.now + 60.0 * 60.0)
        await saveDataToCache(localData)
        return remoteData
      } catch {
        if let cachedData {
          return cachedData.cachedItem
        }
        throw error
      }
    }
  }

  private func readCacheData() async throws -> LocalCacheData<PageItem>? {
    guard let cachedData: LocalCacheData<PageItem> = await dataManager.readCacheData() else {
      return nil
    }

    return cachedData
  }

  private func saveDataToCache(_ data: LocalCacheData<PageItem>) async {
    await dataManager.saveDataToCache(data)
  }
}
