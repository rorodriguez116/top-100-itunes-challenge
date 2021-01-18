//
//  AlbumTableViewCell.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import UIKit
import Combine

class AlbumTableViewCell: UITableViewCell {
        
    private let retriever = ImageRetriever()
    
    private var cancellable: AnyCancellable?
    
    var onReuse: () -> Void = {}
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
//        label.textColor = UIColor.lightText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let albumArtWorkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "placeholder")
        return imageView
    }()
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
                    
        self.addSubview(albumArtWorkImageView)
        self.addSubview(albumNameLabel)
        self.addSubview(artistNameLabel)
        
        albumArtWorkImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        albumArtWorkImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        albumArtWorkImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        albumArtWorkImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        albumNameLabel.leadingAnchor.constraint(equalTo: albumArtWorkImageView.trailingAnchor, constant: 8).isActive = true
        albumNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        albumNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true

        artistNameLabel.leadingAnchor.constraint(equalTo: albumArtWorkImageView.trailingAnchor, constant: 8).isActive = true

        artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 10).isActive = true

    }
    
    override func prepareForReuse() {
        albumArtWorkImageView.image = nil
//        cancellable?.cancel()
    }
    
    func setupData(with album: Album) {
        self.albumNameLabel.text = album.name
        self.artistNameLabel.text = album.artistName
        
        self.albumArtWorkImageView.loadImage(with: album.artworkUrl100)
    }

}
