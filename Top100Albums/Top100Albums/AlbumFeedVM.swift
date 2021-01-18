//
//  AlbumFeedVM.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import Foundation
import UIKit
import Combine

final class AlbumFeedVM<T: GetTop100AlbumsUseCase>: NSObject, AlbumFeedViewModel {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? AlbumTableViewCell {
            cell.setupData(with: albums[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    internal var interactor: T
    
    private var subscriptions = Set<AnyCancellable>()
    
    var binding: (() -> ())?
    
    private(set) var albums = [Album]()
    
    init(interactor: T) {
        self.interactor = interactor
    }
    
    func loadAlbums() {
        interactor.excute().sink { (completion) in
            print(completion)
        } receiveValue: { [weak self] (albums) in
            self?.albums = albums
            self?.binding?()
        }
        .store(in: &self.subscriptions)
    }
}
