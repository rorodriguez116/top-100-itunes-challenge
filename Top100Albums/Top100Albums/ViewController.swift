//
//  ViewController.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import UIKit
import Combine

protocol AlbumFeedViewModel: UITableViewDelegate, UITableViewDataSource {
    associatedtype Interactor: GetTop100AlbumsUseCase
    
    var interactor: Interactor { get set }
    
    var binding: (() -> ())? { get set }

    func loadAlbums()
}

final class AlbumFeedVM<T: GetTop100AlbumsUseCase>: NSObject, AlbumFeedViewModel {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)
        cell.textLabel?.text = albums[indexPath.row].name
        return cell
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

class ViewController<ViewModel: AlbumFeedViewModel>: UIViewController {
    
    var viewModel: ViewModel! {
        didSet {
            refreshData()
        }
    }
        
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: "albumCell")
        return view
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupViews()
        
        setupBinding()
        

        // Do any additional setup after loading the view.
    }
    
    private func setupBinding() {
        viewModel.binding = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        tableView.dataSource = viewModel
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
    
    private func refreshData() {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.loadAlbums()
        
    }
}

