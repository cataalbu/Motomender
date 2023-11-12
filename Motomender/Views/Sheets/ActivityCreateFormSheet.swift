//
//  ActivityFormSheet.swift
//  Motomender
//
//  Created by Catalin Albu on 11.11.2023.
//

import SwiftUI

struct ActivityCreateFormSheet: View {
    
    @ObservedObject var viewModel: ActivityListViewModel
    @ObservedObject var motorcycleViewModel: MotorcycleListViewModel
    @Binding var isPresented: Bool
    
    @State private var name: String = ""
    @State private var selectedDate = Date()
    @State private var selectedMotorcycle: String
    @State private var moneyInvested: String = ""
    @State private var maxKm: String = ""
    @State private var observations: String = ""
    @State private var errorMessages: [String] = []

    init(viewModel: ActivityListViewModel, motorcycleViewModel: MotorcycleListViewModel, isPresented: Binding<Bool>) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self._motorcycleViewModel = ObservedObject(wrappedValue: motorcycleViewModel)
        self._isPresented = isPresented
        
        _selectedMotorcycle = State(initialValue: motorcycleViewModel.motorcycles[0].getFullMotorcycleName())
    }
    
    private var motorcycles: [String] {
        motorcycleViewModel.motorcycles.map { $0.getFullMotorcycleName() }
    }
    var body: some View {
        Form {
                TextField("Acitivity name", text: $name)
                DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                Picker("Motorcycle", selection: $selectedMotorcycle) {
                    ForEach(motorcycles, id: \.self) {
                        Text($0)
                    }
                }
                TextField("MaxKm", text: $maxKm)
                TextField("Money Invested", text: $moneyInvested)
                    .keyboardType(.decimalPad) // For numeric input
                TextField("Observations", text: $observations)
                Button {
                createActivity()
                } label: {
                    Text("Submit")
                }
                
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                .background(.black)
                .cornerRadius(8)
                .foregroundColor(.white)

        }
    }
    
    private func createActivity() {
        if(name.isEmpty) {
            errorMessages.append("Name cannot be empty")
        }
        if errorMessages.isEmpty {
            if let maxKmInt = Int(maxKm),
               let moneyInvestedFloat = Float(moneyInvested) {
                viewModel.addActivity(name: name, date: Date(), maxKm: maxKmInt, motorcycle: selectedMotorcycle, moneyInvested: moneyInvestedFloat, observations: observations)
                isPresented = false
            } else {
                errorMessages.append("Invalid input values")
            }
        }
    }
        
}

