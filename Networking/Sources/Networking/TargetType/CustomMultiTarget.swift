//
//  File.swift
//  Networking
//
//  Created by Tako Metonidze on 3/21/25.
//

import Foundation
import Moya

public struct CustomMultiTarget: CustomTargetType {
  public var authorizationType: AuthorizationType? {
    guard let target = target as? CustomTargetType else {
      return nil
    }
    return target.authorizationType
  }

  private let _baseURL: URL

  /// The baseURL of the embedded target.
  public var baseURL: URL {
    guard let target = target as? CustomTargetType else {
      return _baseURL
    }
    return URL(string: "\(_baseURL.absoluteString)")!
  }

  /// The embedded `TargetType`.
  public let target: TargetType

  /// The embedded target's base `URL`.
  public var path: String { target.path }

  /// The HTTP method of the embedded target.
  public var method: Moya.Method { target.method }

  /// The sampleData of the embedded target.
  public var sampleData: Data { target.sampleData }

  /// The `Task` of the embedded target.
  public var task: Task { target.task }

  /// The `ValidationType` of the embedded target.
  public var validationType: ValidationType { target.validationType }

  /// The headers of the embedded target.
  public var headers: [String: String]? {
    var headers = target.headers
    return headers
  }

  public init(withBaseUrl url: URL, andTarget target: CustomTargetType) {
    self._baseURL = url
    self.target = target
  }
}
