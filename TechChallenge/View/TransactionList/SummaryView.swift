//
//  SummaryView.swift
//  TechChallenge
//
//  Created by Srinidhi on 12/1/21.
//

import SwiftUI

struct SummaryView: View {
    
    @Binding var selectedCatgory: TransactionModel.Category?
    @Binding var sum: Double

    var body: some View {
        HStack(alignment: .bottom) {
            Text("Total spent:")
                .secondary()
            Spacer()
            VStack(alignment:.trailing) {
                Text(selectedCatgory?.rawValue ?? "all")
                    .font(.headline)
                    .foregroundColor(selectedCatgory?.color ?? .accentColor)
                Text("\(sum.currencyFormat)")
                    .foregroundColor(Color.accentColor)
                    .font(.bold(.body)())
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(Color.accentColor, lineWidth: 2.0))
        .padding()
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(selectedCatgory: .constant(nil), sum: .constant(500.45))
    }
}
