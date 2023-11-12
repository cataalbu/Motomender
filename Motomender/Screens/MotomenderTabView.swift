//
//  MotomenderTabView.swift
//  Motomender
//
//  Created by Catalin Albu on 11.11.2023.
//

import SwiftUI

struct MotomenderTabView: View {

    @StateObject var activityViewModel = ActivityListViewModel()
    @StateObject var motorcycleViewModel = MotorcycleListViewModel()

    var body: some View {
        TabView {
            AccountView().tabItem {
                Text("Account")
            }
            MotorcycleListView(viewModel: motorcycleViewModel).tabItem {
                Text("Motorcyles")
            }
            ActivityListView(viewModel: activityViewModel, motorcycleViewModel: motorcycleViewModel).tabItem {
                Text("Activities")
            }
        }
    }
}

#Preview {
    MotomenderTabView()
}
