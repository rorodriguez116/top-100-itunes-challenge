//
//  ViewController.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import UIKit

class ViewController<ViewModel: AlbumFeedViewModel>: UIViewController, UITableViewDelegate {
    
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
        
        self.title = "Top 100 Albums"
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
        tableView.delegate = self
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
    
    private func refreshData() {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.loadAlbums()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AlbumDetailViewController()
        vc.album = viewModel.getAlbum(at: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

