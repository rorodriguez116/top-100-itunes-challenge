//
//  Enums.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import Foundation

enum EntityKind: String, Codable {
    case album
    case song
}

enum AdvisoryRating: String, Codable {
    case explicit = "Explicit"
    case none = ""
}
