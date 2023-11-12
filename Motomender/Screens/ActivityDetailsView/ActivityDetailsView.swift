//
//  ActivityDetailsView.swift
//  Motomender
//
//  Created by Catalin Albu on 11.11.2023.
//

import SwiftUI

struct ActivityDetailsView: View {
    
    @State private var isSheetPresented = false;
    @State private var showingDeleteConfirmation = false;
    @ObservedObject var viewModel: ActivityListViewModel
    @ObservedObject var motorcycleViewModel: MotorcycleListViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView(){
            VStack(alignment: .leading, spacing: 8) {
                HStack() {
                    Text("#" + String(viewModel.selectedActivity?.id ?? 0))
                        .fontWeight(.bold)
                        .font(.system(size: 28))
                    Text(viewModel.selectedActivity?.name ?? "")
                        .fontWeight(.bold)
                        .font(.system(size: 28))
                }
                .padding(.bottom, 32)
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
                                   if(viewModel.selectedActivity != nil && viewModel.selectedActivity?.id != nil) {
                                       viewModel.removeActivity(id: viewModel.selectedActivity?.id)
                                       isPresented = false
                                   }
                               },
                               secondaryButton: .cancel()
                           )
                    }
                }
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Date:")
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                        Text(dateToString(date: viewModel.selectedActivity?.date ?? Date.now))
                            .font(.system(size: 22))
                    }
                    HStack {
                        Text("Motorcyle:")
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                        Text(viewModel.selectedActivity?.motorcycle ?? "")
                            .font(.system(size: 22))
                    }
                    HStack {
                        Text("Money invested:")
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                        Text(String(viewModel.selectedActivity?.moneyInvested ?? 0) + " RON")
                            .font(.system(size: 22))
                    }
                    HStack {
                        Text("Max km:")
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                        Text(String(viewModel.selectedActivity?.maxKm ?? 0) + " km")
                            .font(.system(size: 22))
                    }
                    VStack(alignment: .leading) {
                        Text("Observations:")
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                        Text(viewModel.selectedActivity?.observations ?? "")
                            .font(.system(size: 20))
                            .padding(.top, 16)
                    }
                }
                .padding(.vertical, 32)
                Spacer()

            }
            .navigationTitle("Activity details")
            .padding(32)
        }
        .sheet(isPresented: $isSheetPresented) {
            ActivityUpdateFormSheet(viewModel: viewModel,
                                    motorcycleViewModel: motorcycleViewModel,
                                    isPresented: $isPresented)
        }
    }
    private func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
}


struct ActivityDetailsView_Previews: PreviewProvider{
    static var previews: some View{
            let viewModel = ActivityListViewModel()
            let motorcycleViewModel = MotorcycleListViewModel()
            let isPresented = Binding<Bool>(
                get: { return true },
                set: { _ in}
            )
            ActivityDetailsView(viewModel: viewModel,
                                motorcycleViewModel: motorcycleViewModel,
                                isPresented: isPresented)
        }
}
