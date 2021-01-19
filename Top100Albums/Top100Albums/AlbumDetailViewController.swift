//
//  AlbumDetailViewController.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import UIKit

class AlbumDetailViewController: UIViewController {

    var album: Album!
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        return label
    }()

    private let copyrightInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        return label
    }()

    
    private let albumArtWorkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "placeholder")
        return imageView
    }()
    
    private let itunesButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open in iTunes Store", for: .normal)
        button.backgroundColor = UIColor.oceanBlue
        button.addTarget(self, action: #selector(openItunes), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.08
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 16
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(albumArtWorkImageView)
        self.view.addSubview(itunesButton)
        
        let stackView = UIStackView(arrangedSubviews: [genreLabel, releaseDateLabel, copyrightInfoLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        let stackView2 = UIStackView(arrangedSubviews: [albumNameLabel, artistNameLabel])
        stackView2.axis = .vertical
        stackView2.distribution = .fillEqually
        stackView2.alignment = .fill
        stackView2.spacing = 2
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView2)
        
        albumArtWorkImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        albumArtWorkImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        albumArtWorkImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        albumArtWorkImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true 
        
        stackView2.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32).isActive = true
        stackView2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView2.topAnchor.constraint(equalTo: albumArtWorkImageView.bottomAnchor, constant: 10).isActive = true
        
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: stackView2.bottomAnchor, constant: 8).isActive = true
            
        itunesButton.topAnchor.constraint(equalTo: stackView2.bottomAnchor, constant: 80).isActive = true
        itunesButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32).isActive = true
        itunesButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        itunesButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
      
        albumArtWorkImageView.loadImage(with: album.artworkUrl100)
        
        albumNameLabel.text = album.name
        artistNameLabel.text = album.artistName
        
        copyrightInfoLabel.text = album.copyright
        genreLabel.text = album.genres.first?.name
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let releaseDateString = formatter.string(from: album.releaseDate)
        
        releaseDateLabel.text = releaseDateString
        
        self.title = album.name
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc
    func openItunes() {
        UIApplication.shared.open(self.album.url)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIColor {
    static var oceanBlue: UIColor {
        return UIColor(named: "oceanBlue") ?? .blue
    }
}
