//
//  AlbumMapper.swift
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
}

struct Genre: Codable {
    let id: String
    let name: String
    let url: URL
}

enum MappingError: Error {
    case jsonDataDoesNotContainProperModel
}

struct GenreMapper: Mapper {    
    struct Data: Codable {
        let genreId: String
        let name: String
        let url: URL
    }
    
    var dictionary: [String : Any]
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
    }
    
    func execute() throws -> Genre {
        guard let data = Data(dictionary: self.dictionary) else { throw MappingError.jsonDataDoesNotContainProperModel}
        return Genre(id: data.genreId, name: data.name, url: data.url)
    }
}

struct AlbumMapper: Mapper {
    struct Data: Codable {
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
    
    var dictionary: [String : Any]
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
    }
    
    func execute() throws -> Album {
        guard let data = Data(dictionary: self.dictionary) else { throw MappingError.jsonDataDoesNotContainProperModel}
        return Album(artistNam: data.artistNam, id: data.id, releaseDate: data.releaseDate, name: data.name, kind: data.kind, copyright: data.copyright, artistId: data.artistId, contentAdvisoryRating: data.contentAdvisoryRating, artistUrl: data.artistUrl, artworkUrl100: data.artworkUrl100, genres: data.genres, url: data.url)
    }
}
