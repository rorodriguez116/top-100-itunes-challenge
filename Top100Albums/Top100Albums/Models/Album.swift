//
//  Album.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import Foundation

struct Album: Codable {
    let artistNam: String
    let id: String
    let releaseDate: Date //"2021-01-08",
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
