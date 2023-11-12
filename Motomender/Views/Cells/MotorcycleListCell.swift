//
//  MotorcycleListCell.swift
//  Motomender
//
//  Created by Catalin Albu on 11.11.2023.
//

import SwiftUI

struct MotorcycleListCell: View {
    
    var motorcyle: Motorcycle
    var onDetailsPressed: () -> Void = {}
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("#" + String(motorcyle.id))
                    .fontWeight(.bold)
                Text(motorcyle.getFullMotorcycleName())
            }
            HStack {
                Text("KM:")
                    .fontWeight(.bold)
                Text(String(motorcyle.km))
            }
        
            HStack {
                Spacer()
                Button {
                    onDetailsPressed()
                } label: {
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
    
}

