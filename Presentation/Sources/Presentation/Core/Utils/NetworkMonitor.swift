//
//  File.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/24/25.
//

import Foundation
import Network

@MainActor
final public class NetworkMonitor {
  @MainActor static public let shared = NetworkMonitor()

  private let monitor = NWPathMonitor()
  private let queue = DispatchQueue(label: "NetworkMonitorQueue")

  var isConnected: Bool = true
  public var onStatusChange: ((Bool) -> Void)?

  private init() {
    monitor.pathUpdateHandler = { [weak self] path in
      Task { @MainActor [weak self] in
        guard let self else { return }
        let newStatus = path.status == .satisfied
        if newStatus != self.isConnected {
          self.isConnected = newStatus
          self.onStatusChange?(newStatus)
        }
      }
    }
    monitor.start(queue: queue)
  }
}
