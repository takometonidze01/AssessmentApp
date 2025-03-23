//
//  FormItemType.swift
//  Domain
//
//  Created by Tako Metonidze on 3/23/25.
//

import Foundation

public enum FormItemType: String, Decodable, Sendable {
    case page
    case section
    case text
    case image
}
