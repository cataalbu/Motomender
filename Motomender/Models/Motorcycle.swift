//
//  Motorcycle.swift
//  Motomender
//
//  Created by Catalin Albu on 12.11.2023.
//

import Foundation

struct Motorcycle: Identifiable {
    var id: Int;
    var manufacturer: String;
    var model: String;
    var km: Int;
    
    func getFullMotorcycleName() -> String {
        return manufacturer + " " + model
    }
}
