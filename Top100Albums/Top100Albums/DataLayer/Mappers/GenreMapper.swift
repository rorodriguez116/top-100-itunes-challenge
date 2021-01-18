//
//  GenreMapper.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import Foundation

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
