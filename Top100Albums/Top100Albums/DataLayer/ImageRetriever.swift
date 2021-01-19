//
//  ImageRetriever.swift
//  Top100Albums
//
//  Created by Rolando Rodriguez on 1/18/21.
//

import Foundation
import UIKit
import Combine

final class ImageRetriever {
    enum RetrivingError: Error {
        case errorRetrievingRemoteImage
    }
    
    private var loadedImages = [URL: UIImage]()
    private var onGoingRequests = [UUID: URLSessionDataTask]()
    
    func loadImage(with url: URL) -> AnyPublisher<UIImage, RetrivingError> {
        if let image = loadedImages[url] {
            return Future<UIImage, RetrivingError> { promise in
                promise(.success(image))
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        } else {
            return URLSession.shared.dataTaskPublisher(for: url)
                        .map({ (data, response) -> UIImage in
                            if let image = UIImage(data: data) {
                                self.loadedImages[url] = image
                                return image
                            } else {
                                return UIImage(named: "placeholder")!
                            }
                        })
                        .mapError({ (err) -> RetrivingError in
                            return RetrivingError.errorRetrievingRemoteImage
                        })
                        .receive(on: RunLoop.main)
                        .eraseToAnyPublisher()
        }
    }
    
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }
        
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            defer {self.onGoingRequests.removeValue(forKey: uuid) }
            
            if let data = data, let image = UIImage(data: data) {
                self.loadedImages[url] = image
                completion(.success(image))
                return
            }
            
            guard let error = error else {
                return
            }
            
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
        }
        
        task.resume()
        
        onGoingRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        onGoingRequests[uuid]?.cancel()
        onGoingRequests.removeValue(forKey: uuid)
    }
}

