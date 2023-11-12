//
//  MotorcycleListView.swift
//  Motomender
//
//  Created by Catalin Albu on 11.11.2023.
//

import SwiftUI

struct MotorcycleListView: View {
    
    @State private var isCreateSheetOpen = false;
    @State private var isLinkActive = false;
    @ObservedObject var viewModel: MotorcycleListViewModel

    func handleDetailsPressed(motorcycle: Motorcycle) {
        print(motorcycle)
        viewModel.selectedMotorcycle = motorcycle
        isLinkActive = true;
    }
    
    var body: some View {
        ZStack{
            NavigationStack {
                VStack {
                    Button {
                        isCreateSheetOpen = true;
                    } label: {
                        Text("Add new")
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    .background(.black)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    List(viewModel.motorcycles) { motorcycle in
                        MotorcycleListCell(motorcyle: motorcycle, onDetailsPressed: {
                            handleDetailsPressed(motorcycle: motorcycle)
                        })
                    }
                }
                .navigationTitle("Motorcycles")
                .navigationDestination(isPresented: $isLinkActive) {
                    MotorcycleDetailsView(viewModel: viewModel, isPresented: $isLinkActive)
                }
            }
        }
        .sheet(isPresented: $isCreateSheetOpen) {
            MotorcyleCreateFormSheet(viewModel: viewModel, isPresented: $isCreateSheetOpen)
        }
    }
}

struct MotorcycleListView_Previews: PreviewProvider{
    static var previews: some View{
        let viewModel = MotorcycleListViewModel()

        MotorcycleListView(viewModel: viewModel )
        }
}
