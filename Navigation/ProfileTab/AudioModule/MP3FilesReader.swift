//
//  FileReader.swift
//  Navigation
//
//  Created by Миша on 08.12.2021.
//

import Foundation

import UIKit
 
class MP3FilesReader: NSObject {
    class func readFiles() -> [String] {
        return Bundle.main.paths(forResourcesOfType: "mp3", inDirectory: nil)
    }
}
