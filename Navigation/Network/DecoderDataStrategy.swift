//
//  DecoderDataStrategy.swift
//  Navigation
//
//  Created by Миша on 24.02.2022.
//

import Foundation

extension JSONDecoder {
    var dateFormater: DateFormatter {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormater
    }
}
