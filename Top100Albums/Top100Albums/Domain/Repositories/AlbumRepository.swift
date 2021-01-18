//
//  AlbumRepository.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import Foundation
import Combine

protocol AlbumRepository {
    func getTop100() -> AnyPublisher<[Album], Error>
}
