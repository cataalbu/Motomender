//
//  MotorcycleUpdateFormSheet.swift
//  Motomender
//
//  Created by Catalin Albu on 12.11.2023.
//

import SwiftUI

struct MotorcyleUpdateFormSheet: View {
    
    @ObservedObject var viewModel: MotorcycleListViewModel
    @Binding var isPresented: Bool
    
    @State private var manufacturer: String
    @State private var model: String
    @State private var kilometers: String
    @State private var errorMessages: [String] = []
    
    init(viewModel: MotorcycleListViewModel, isPresented: Binding<Bool>) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self._isPresented = isPresented
        
        _manufacturer = State(initialValue: viewModel.selectedMotorcycle?.manufacturer ?? "")
        _model = State(initialValue: viewModel.selectedMotorcycle?.model ?? "")
        _kilometers = State(initialValue: String(viewModel.selectedMotorcycle?.km ?? 0))
    }
    
    var body: some View {
        Form {
                TextField("Manufacturer", text: $manufacturer)
                TextField("Model", text: $model)
                TextField("Kilometers", text: $kilometers).keyboardType(.numberPad)
                Button {
                    updateMotorcycle()
                } label: {
                    Text("Submit")
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .background(.black)
                .cornerRadius(8)
                .foregroundColor(.white)
                .padding(.top, 32)
        }
    }
    
    private func updateMotorcycle() {
        if(manufacturer.isEmpty) {
            errorMessages.append("Manufacturer cannot be empty")
        }
        if errorMessages.isEmpty {
            if let kmInt = Int(kilometers),
            let selectedMotorcycle = viewModel.selectedMotorcycle{
                viewModel.updateMotorcycle(id: selectedMotorcycle.id, manufacturer: manufacturer, model: model, km: kmInt)
                isPresented = false
            } else {
                errorMessages.append("Invalid input values")
            }
        }
    }
}
