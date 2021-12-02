//
//  CategoryFilterView.swift
//  TechChallenge
//
//  Created by Srinidhi on 12/1/21.
//

import SwiftUI

struct CategoryFilterView: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Button("all"){}
                    .buttonStyle(FilterButtonStyle(color: .black))
                
                ForEach(TransactionModel.Category.allCases) { eachCategory in
                    Button(eachCategory.rawValue) {}
                        .buttonStyle(FilterButtonStyle(color: eachCategory.color))
                }
            }
            .padding()
        }
        .background(Color.accentColor.opacity(0.8))
    }
}

struct CategoryFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryFilterView()
    }
}
