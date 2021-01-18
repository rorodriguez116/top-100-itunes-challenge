//
//  GetTop100AlbumsUseCase.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import Foundation
import Combine

protocol GetTop100AlbumsUseCase {
    var repository: AlbumRepository { get set }
    
    func excute() -> AnyPublisher<[Album], Error>
}
