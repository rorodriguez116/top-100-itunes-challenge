//
//  UIImageView+Extensions.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import Foundation
import UIKit
import Combine

extension UIImageView {
    func load(url: URL) -> AnyCancellable {
        let retriever = ImageRetriever()
        let task = retriever.loadImage(with: url)
        let publisher = task
        
        return publisher.sink { [weak self] (completion) in
            print("Finished retrieving image:", completion)
            
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.image = UIImage(named: "placeholder")
            }
        } receiveValue: { [weak self] (image) in
            self?.image = image
        }
    }
    
    func loadImage(with url: URL) {
      UIImageLoader.loader.load(url, for: self)
    }

    func cancelImageLoad() {
      UIImageLoader.loader.cancel(for: self)
    }
}
