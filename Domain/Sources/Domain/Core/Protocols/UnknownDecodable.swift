//
//  UnknownDecodable.swift
//  Domain
//
//  Created by Tako Metonidze on 3/23/25.
//

public protocol UnknownDecodable: Decodable where Self: RawRepresentable {
  static var unknown: Self { get }
}

public extension UnknownDecodable where RawValue: Decodable {
  init(from decoder: Decoder) throws {
    self = if let rawValue = try? decoder.singleValueContainer().decode(RawValue.self) {
      .init(rawValue: rawValue) ?? .unknown
    } else {
      .unknown
    }
  }
}
