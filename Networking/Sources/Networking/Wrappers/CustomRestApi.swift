//
//  File.swift
//  Networking
//
//  Created by Tako Metonidze on 3/21/25.
//

import Moya
import Foundation

public final class CustomRestApi: Sendable {
  private let baseURL: URL
  private let provider: CustomNetworkingProvider<CustomMultiTarget>

  public init(
    baseURL url: URL,
    accessTokenSource: AccessTokenSource,
    unAuthorizedRequestHandler: UnAuthorizedHandlerType
  ) {
    baseURL = url
    provider = CustomNetworkingProvider<CustomMultiTarget>(accessTokenSource: accessTokenSource, unAuthorizedRequestHandler: unAuthorizedRequestHandler)
  }

  public func request<ResponseType: Decodable>(_ target: CustomTargetType) async throws -> ResponseType {
    return try await provider.request(CustomMultiTarget(withBaseUrl: baseURL, andTarget: target))
  }

  public func requestWithProgress<ResponseType: Decodable>(_ target: CustomTargetType, progress: @escaping ProgressBlock) async throws -> ResponseType {
    return try await provider
      .request(CustomMultiTarget(withBaseUrl: baseURL, andTarget: target), progress: progress)
  }
}
