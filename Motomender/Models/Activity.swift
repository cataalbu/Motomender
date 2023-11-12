//
//  Activity.swift
//  Motomender
//
//  Created by Catalin Albu on 12.11.2023.
//

import Foundation

struct Activity: Identifiable {
    var id: Int;
    var name: String;
    var date: Date;
    var maxKm: Int;
    var motorcycle: String;
    var moneyInvested: Float;
    var observations: String;
}
