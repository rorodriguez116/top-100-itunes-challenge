//
//  Album.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import Foundation

struct Album: Codable {
    let artistName: String
    let id: String
    let releaseDate: Date
    let name: String
    let kind: EntityKind
    let copyright: String
    let artistId: String
    let contentAdvisoryRating: AdvisoryRating
    let artistUrl: URL
    let artworkUrl100: URL
    let genres: [GenreMapper.Data]
    let url: URL
}
