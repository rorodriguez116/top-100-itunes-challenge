//
//  ViewController.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import UIKit
import Combine

final class AlbumFeedViewModel {
    
    func getAlbums() {
        
    }
}

class ViewController: UIViewController {

    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        // Do any additional setup after loading the view.
    }
    
    private func setupViews() {
        
    }
}

