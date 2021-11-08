//
//  CheckText.swift
//  Navigation
//
//  Created by Миша on 29.09.2021.
//

import Foundation

struct CheckText {
    
    private static let testWord = "Swift"
    
    var check = { $0 == testWord }
}
