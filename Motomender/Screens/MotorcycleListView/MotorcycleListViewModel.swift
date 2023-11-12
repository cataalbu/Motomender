//
//  MotorcycleModelListView.swift
//  Motomender
//
//  Created by Catalin Albu on 12.11.2023.
//

import Foundation

final class MotorcycleListViewModel: ObservableObject {
    @Published var motorcycles: [Motorcycle] = [
        Motorcycle(id: 1, manufacturer: "Honda", model: "CB500F", km: 34000)
    ]
    @Published var selectedMotorcycle: Motorcycle?
    private var nextId: Int = 2

    func addMotorcycle(manufacturer: String, model: String, km: Int) {
        let newMotorcycle = Motorcycle(id: nextId, manufacturer: manufacturer, model: model, km: km)
        motorcycles.append(newMotorcycle)
        nextId += 1
        print(motorcycles)
    }

    func updateMotorcycle(id: Int, manufacturer: String, model: String, km: Int) {
        if let index = motorcycles.firstIndex(where: { $0.id == id }) {
            motorcycles[index].manufacturer = manufacturer
            motorcycles[index].model = model
            motorcycles[index].km = km
        }
    }

    func removeMotorcycle(id: Int) {
        motorcycles.removeAll { $0.id == id }
    }
}
