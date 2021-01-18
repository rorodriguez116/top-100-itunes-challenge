//
//  AlbumRepository.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import Foundation

protocol AlbumRepository {
    func getTop100() -> [Album]
}
