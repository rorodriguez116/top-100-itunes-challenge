//
//  Mapper.swift
//  MyPay
//
//  Created by Rolando Rodriguez on 11/25/20.
//  Copyright © 2020 Rolando Rodriguez. All rights reserved.
//

import Foundation

protocol Mapper {
    associatedtype T: Codable
    
    func execute() -> T
    
    var dictionary: [String: Any] { get set }
    
    init(dictionary: [String: Any])

}
