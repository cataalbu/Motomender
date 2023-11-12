//
//  MotorcyleFormSheet.swift
//  Motomender
//
//  Created by Catalin Albu on 11.11.2023.
//

import SwiftUI

struct MotorcyleCreateFormSheet: View {
    
    @ObservedObject var viewModel: MotorcycleListViewModel
    @Binding var isPresented: Bool
    
    @State private var manufacturer: String = ""
    @State private var model: String = ""
    @State private var kilometers: String = ""
    @State private var errorMessages: [String] = []
    
    var body: some View {
        Form {
                TextField("Manufacturer", text: $manufacturer)
                TextField("Model", text: $model)
                TextField("Kilometers", text: $kilometers).keyboardType(.numberPad)
                Button {
                    createMotorcycle()
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
    
    private func createMotorcycle() {
        if(manufacturer.isEmpty) {
            errorMessages.append("Manufacturer cannot be empty")
        }
        if errorMessages.isEmpty {
            if let kmInt = Int(kilometers) {
                viewModel.addMotorcycle(manufacturer: manufacturer, model: model, km: kmInt)
                isPresented = false
            } else {
                errorMessages.append("Invalid input values")
            }
        }
    }
}
