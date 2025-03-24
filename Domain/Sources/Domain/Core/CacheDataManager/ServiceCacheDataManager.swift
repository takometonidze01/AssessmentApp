//
//  ServicesCacheDataManager.swift
//  Domain
//
//  Created by Tako Metonidze on 3/24/25.
//

import Foundation

public actor ServicesCacheDataManager {
  let cacheFileName: String

  var cacheURL: URL {
    do {
      return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        .appendingPathComponent(cacheFileName)
    } catch {
      fatalError("Error while accessing document directory: \(error)")
    }
  }

  public init(title: String = "form", fileName: String = ".json") {
    cacheFileName = "eng_\(title)ServicesCache\(fileName)"
  }

  public func saveDataToCache<T: Encodable>(_ data: T) {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted

    do {
      let encodedData = try encoder.encode(data)
      try encodedData.write(to: cacheURL)
      print("Data saved to cache successfully.")
    } catch {
      print("Error saving data to cache:", error.localizedDescription)
    }
  }

  // MARK: - Read Data from File
  func readCacheData<T: Decodable>() -> T? {
    do {
      let data = try Data(contentsOf: cacheURL)
      let decoder = JSONDecoder()
      let decodedData = try decoder.decode(T.self, from: data)
      return decodedData
    } catch {
      print("Error reading cache data:", error.localizedDescription)
      return nil
    }
  }

  // MARK: - Delete Cache File
  public func deleteCacheFile() {
    do {
      try FileManager.default.removeItem(at: cacheURL)
      print("Cache file deleted successfully.")
    } catch {
      print("Error deleting cache file:", error.localizedDescription)
    }
  }
}
