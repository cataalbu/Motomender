//
//  AcitivityListViewModel.swift
//  Motomender
//
//  Created by Catalin Albu on 12.11.2023.
//

import Foundation

final class ActivityListViewModel: ObservableObject {
    @Published var activities: [Activity] = [
        Activity(id: 1, name: "Chain cleaning", date: Date.now, maxKm: 7000, motorcycle: "Honda CB500F", moneyInvested: 35.99, observations: "Yasss")
    ]
    @Published var selectedActivity: Activity?
    private var nextId: Int = 2
    
    func addActivity(name: String, date: Date, maxKm: Int, motorcycle: String, moneyInvested: Float, observations:String) {
        activities.append(Activity(id: nextId, name: name, date: date, maxKm: maxKm, motorcycle: motorcycle, moneyInvested: moneyInvested, observations: observations))
        nextId+=1
    }
    
    func updateActivity(id: Int, name: String, date: Date, maxKm: Int, motorcycle: String, moneyInvested: Float, observations:String) {
        if let index = activities.firstIndex(where: { $0.id == id }) {
                activities[index].name = name
                activities[index].date = date
                activities[index].maxKm = maxKm
                activities[index].motorcycle = motorcycle
                activities[index].moneyInvested = moneyInvested
                activities[index].observations = observations
            }
    }
    func removeActivity(id: Int?) {
        if(id != nil)
        {
            activities.removeAll { $0.id == id }
            selectedActivity = nil
        }
    }
}
