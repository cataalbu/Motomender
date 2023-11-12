//
//  ActivityListView.swift
//  Motomender
//
//  Created by Catalin Albu on 11.11.2023.
//

import SwiftUI

struct ActivityListView: View {
    
    @State private var isCreateSheetOpen = false;
    @State private var isLinkActive = false;
    @ObservedObject var viewModel: ActivityListViewModel
    @ObservedObject var motorcycleViewModel: MotorcycleListViewModel
    
    func handleDetailsPressed(activity: Activity) {
        viewModel.selectedActivity = activity
        isLinkActive = true;
    }
    
    var body: some View {
        ZStack{
             NavigationStack{
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
                    List(viewModel.activities) { activity in
                        ActivityListCell(activity: activity, onDetailsPressed: {handleDetailsPressed(activity: activity)})
                    }
                    .navigationTitle("Acitivities")
                    .navigationDestination(isPresented: $isLinkActive) {
                        ActivityDetailsView(viewModel: viewModel, motorcycleViewModel: motorcycleViewModel, isPresented: $isLinkActive)
                    }
                }
            }
        }
        .sheet(isPresented: $isCreateSheetOpen) {
            ActivityCreateFormSheet( viewModel: viewModel, motorcycleViewModel: motorcycleViewModel, isPresented: $isCreateSheetOpen)
        }
    }
}


struct ActivityListView_Previews: PreviewProvider{
    static var previews: some View{
        let viewModel = ActivityListViewModel()
        let motorcycleModelView = MotorcycleListViewModel()
        ActivityListView(viewModel: viewModel, motorcycleViewModel: motorcycleModelView)
        }
}
