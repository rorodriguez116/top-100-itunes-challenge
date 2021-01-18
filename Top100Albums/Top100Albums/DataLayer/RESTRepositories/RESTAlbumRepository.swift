//
//  RESTAlbumRepository.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import Foundation
import Combine

struct RESTAlbumRepository: AlbumRepository {
    let client = NetworkAPIClient()
    
    func getTop100() -> AnyPublisher<[Album], Error> {
        let builder = ApiRequest.Builder()
        builder.withPath("/api/").withVersion("v1/us/").withResource("apple-music/top-albums/").withEndPoint("all/100/explicit.json").withType(.get)
        let request = builder.build()
        return client.call(request: request)
            .tryMap({ (rawData) -> [Album] in
                if let feed = rawData["feed"] as? [String: Any], let results = feed["results"] as? [[String: Any]] {
                    return results.compactMap {
                        do { return try AlbumMapper(dictionary: $0).execute() }
                        catch { return nil }
                    }
                } else {
                    throw NetworkAPIClient.CallError.decodingError(.couldNotUnwrapData)
                }
            })
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
