//
//  ActivityListCell.swift
//  Motomender
//
//  Created by Catalin Albu on 11.11.2023.
//

import SwiftUI

struct ActivityListCell: View {

    var activity: Activity
    var onDetailsPressed: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("#1")
                    .fontWeight(.bold)
                Text(activity.name)
            }
            HStack {
                Text("Date:")
                    .fontWeight(.bold)
                Text(dateToString(date: activity.date))
            }
            HStack {
                Text("Motorcycle:")
                    .fontWeight(.bold)
                Text(activity.motorcycle)
            }
            HStack {
                Spacer()
                Button(action: onDetailsPressed) {
                   Text("Details")
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                .background(.black)
                .cornerRadius(8)
                .foregroundColor(.white)
                Spacer()
            }
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 2)
        )

    }
    private func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    ActivityListCell(activity: Activity(id: 1, name: "Chain cleaning", date: Date(), maxKm: 7000, motorcycle: "Honda CB500F", moneyInvested: 35.99, observations: "Yasss")
)
}
