//
//  AlbumFeedViewModel.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import Foundation
import UIKit

protocol AlbumFeedViewModel: UITableViewDataSource {
    associatedtype Interactor: GetTop100AlbumsUseCase
    
    var interactor: Interactor { get set }
    
    var binding: (() -> ())? { get set }

    func loadAlbums()
    
    func getAlbum(at index: Int) -> Album
}
