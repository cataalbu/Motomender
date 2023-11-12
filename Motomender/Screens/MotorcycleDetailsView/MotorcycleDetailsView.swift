//
//  MotorcycleDetailsView.swift
//  Motomender
//
//  Created by Catalin Albu on 11.11.2023.
//

import SwiftUI

struct MotorcycleDetailsView: View {
    
    @State private var isSheetPresented = false;
    @State private var showingDeleteConfirmation = false;
    @ObservedObject var viewModel: MotorcycleListViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView(){
            VStack(alignment: .leading, spacing: 8) {
               
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Manufacturer:")
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                        Text(viewModel.selectedMotorcycle?.manufacturer ?? "")
                            .font(.system(size: 22))
                    }
                    HStack {
                        Text("Model:")
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                        Text(viewModel.selectedMotorcycle?.model ?? "")
                            .font(.system(size: 22))
                    }
                    HStack {
                        Text("Km:")
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                        Text(String(viewModel.selectedMotorcycle?.km ?? 0))
                            .font(.system(size: 22))
                    }
                }
                .padding(.vertical, 32)
                HStack() {
                    Button {
                        isSheetPresented = true;
                    } label: {
                       Text("Update")
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    .background(.black)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    Spacer()
                    Button {
                        showingDeleteConfirmation = true;
                    } label: {
                       Text("Delete")
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    .background(.red)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .alert(isPresented: $showingDeleteConfirmation) {
                        Alert(
                               title: Text("Are you sure you want to delete this?"),
                               primaryButton: .destructive(Text("Delete")) {
                                   if(viewModel.selectedMotorcycle != nil && viewModel.selectedMotorcycle?.id != nil) {
                                       viewModel.removeMotorcycle(id: viewModel.selectedMotorcycle!.id)
                                       isPresented = false
                                   }
                               },
                               secondaryButton: .cancel()
                           )
                    }
                }
                Spacer()

            }
            .navigationTitle("Motorcyle details")
            .padding(32)
        }
        .sheet(isPresented: $isSheetPresented) {
            MotorcyleUpdateFormSheet(viewModel: viewModel, isPresented: $isPresented)
        }
    }
}

struct MotorcyleDetailsView_Previews: PreviewProvider{
    static var previews: some View{
            let viewModel = MotorcycleListViewModel()
            let isPresented = Binding<Bool>(
                get: { return true },
                set: { _ in}
            )
        MotorcycleDetailsView(viewModel: viewModel, isPresented: isPresented)
        }
}
