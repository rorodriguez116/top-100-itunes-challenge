//
//  ViewController.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import UIKit

class ViewController<ViewModel: AlbumFeedViewModel>: UIViewController {
    
    var viewModel: ViewModel! {
        didSet {
            refreshData()
        }
    }
        
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(AlbumTableViewCell.self, forCellReuseIdentifier: "albumCell")
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
        tableView.delegate = viewModel
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

