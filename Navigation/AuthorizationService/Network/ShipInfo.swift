//
//  ShipInfo.swift
//  Navigation
//
//  Created by Миша on 11.02.2022.
//

import Foundation

struct ShipInfo: Codable {
    
    let Name: String
    let Model: String
    let Manufacturer: String
    let Cost: String
    let Length: String
    let MaxSpeed: String
    let Crew: String
    let Passengers: String
    let CargoCapacity: String
    let Consumables: String
    let HyperdriveRating: String
    let MGLT: String
    let Class: String
    let Pilots: [String]
    let Films: [String]
    let Created: String
    let Edited: String
    let URL: String

    
    enum CodingKeys: String, CodingKey {
        case Name = "name"
        case Model = "model"
        case Manufacturer = "manufacturer"
        case Cost = "cost_in_credits"
        case Length = "length"
        case MaxSpeed = "max_atmosphering_speed"
        case Crew = "crew"
        case Passengers = "passengers"
        case CargoCapacity = "cargo_capacity"
        case Consumables = "consumables"
        case HyperdriveRating = "hyperdrive_rating"
        case MGLT = "MGLT"
        case Class = "starship_class"
        case Pilots = "pilots"
        case Films = "films"
        case Created = "created"
        case Edited = "edited"
        case URL = "url"
    }
}
