//
//  GetTop100AlbumsInteractor.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import Foundation
import Combine

struct GetTop100AlbumsInteractor: GetTop100AlbumsUseCase {
    var repository: AlbumRepository
    
    func excute() -> AnyPublisher<[Album], Error> {
        repository.getTop100()
    }
}
