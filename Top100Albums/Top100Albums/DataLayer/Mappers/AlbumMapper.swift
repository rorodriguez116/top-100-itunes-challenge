//
//  AlbumMapper.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import Foundation

struct AlbumMapper: Mapper {
    struct Data: Codable {
        let artistName: String
        let id: String
        let releaseDate: String
        let name: String
        let kind: EntityKind
        let copyright: String
        let artistId: String
        let contentAdvisoryRating: AdvisoryRating?
        let artistUrl: URL
        let artworkUrl100: URL
        let genres: [GenreMapper.Data]
        let url: URL
    }
    
    var dictionary: [String : Any]
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
    }
    
    func execute() throws -> Album {
        guard let data = Data(dictionary: self.dictionary) else { throw MappingError.jsonDataDoesNotContainProperModel}
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let releaseDate = formatter.date(from: data.releaseDate)
        return Album(artistName: data.artistName, id: data.id, releaseDate: releaseDate ?? Date(), name: data.name, kind: data.kind, copyright: data.copyright, artistId: data.artistId, contentAdvisoryRating: data.contentAdvisoryRating ?? .none, artistUrl: data.artistUrl, artworkUrl100: data.artworkUrl100, genres: data.genres, url: data.url)
    }
}
