//
//  CustomNetworkingProvider.swift
//  Networking
//
//  Created by Tako Metonidze on 3/21/25.
//

import Foundation
@preconcurrency import Moya
import Alamofire
import UIKit

final class CustomNetworkingProvider<Target>: Sendable where Target: Moya.TargetType {
  private let provider: MoyaProvider<Target>

  public init(
    endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
    requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
    stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
    callbackQueue: DispatchQueue? = nil,
    trackInflights: Bool = false
  ) {
    let configuration = URLSessionConfiguration.af.default
    configuration.timeoutIntervalForRequest = 30.0

    let session: Session = .init(configuration: configuration)

    self.provider = MoyaProvider(
      endpointClosure: endpointClosure,
      requestClosure: requestClosure,
      stubClosure: stubClosure,
      callbackQueue: callbackQueue,
      session: session,
      plugins: [
        NetworkLoggerPlugin(
          configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        )
      ],
      trackInflights: trackInflights
    )
  }

  public func request<ResponseType: Decodable>(_ target: Target, progress: @escaping ProgressBlock = { _ in }) async throws -> ResponseType {
    let asyncRequestWrapper = AsyncMoyaRequestWrapper { [weak self] continuation in
      guard let self = self else {
        return nil
      }
      return self.request(target, progress: progress) { result in
        switch result {
        case .success(let response):
          continuation.resume(returning: .success(response))
        case .failure(let moyaError):
          continuation.resume(returning: .failure(moyaError))
        }
      }
    }

    return try await withTaskCancellationHandler(operation: {
      let response = await withCheckedContinuation({ continuation in
        asyncRequestWrapper.perform(continuation: continuation)
      })

      switch response {
      case .success(let success):
        do {
          return try handleSuccess(response: success)
        } catch {
          guard let moayaError = error as? MoyaError else {
            throw error
          }
          throw handleFailure(failure: moayaError)
        }
      case .failure(let failure):
        throw handleFailure(failure: failure)
      }
    }, onCancel: {
      asyncRequestWrapper.cancel()
    })
  }

  private func handleFailure(failure: MoyaError) -> Error {
    if let response = failure.response {
      let statusCode = response.statusCode
      let errorMessage = (try? response.mapJSON() as? [String: Any])?["message"] as? String ?? "Unknown error occurred"
      return NSError(domain: "NetworkingError", code: statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
    }

    return failure
  }

  private func handleSuccess<ResponseType: Decodable>(response: Response) throws -> ResponseType {
    let filteredResponse = try response.filterSuccessfulStatusCodes()
    return try filteredResponse.map(ResponseType.self)
  }

  private func request(
    _ target: Target,
    callbackQueue: DispatchQueue? = .none,
    progress: ProgressBlock? = .none,
    completion: @escaping Completion
  ) -> Cancellable {
    return provider.request(target, callbackQueue: callbackQueue, progress: progress, completion: completion)
  }
}

extension Moya.Response: @unchecked Sendable { }
