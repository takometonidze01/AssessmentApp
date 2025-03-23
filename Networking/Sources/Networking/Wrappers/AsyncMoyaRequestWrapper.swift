//
//  AsyncMoyaRequestWrapper.swift
//  Networking
//
//  Created by Tako Metonidze on 3/21/25.
//

@preconcurrency import Moya

final class AsyncMoyaRequestWrapper: @unchecked Sendable {
  internal typealias MoyaContinuation = CheckedContinuation<Result<Response, MoyaError>, Never>

  var performRequest: (MoyaContinuation) -> Moya.Cancellable?
  var cancellable: Moya.Cancellable?

  init(_ performRequest: @escaping (MoyaContinuation) -> Moya.Cancellable?) {
    self.performRequest = performRequest
  }

  func perform(continuation: MoyaContinuation) {
    cancellable = performRequest(continuation)
  }

  func cancel() {
    cancellable?.cancel()
  }
}
