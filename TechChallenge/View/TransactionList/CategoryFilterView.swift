//
//  CategoryFilterView.swift
//  TechChallenge
//
//  Created by Srinidhi on 12/1/21.
//

import SwiftUI

struct CategoryFilterView: View {
    @Binding var selectedCatgory: TransactionModel.Category?
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Button("all"){ selectedCatgory = nil }
                    .buttonStyle(FilterButtonStyle(color: .black))
                
                ForEach(TransactionModel.Category.allCases) { eachCategory in
                    Button(eachCategory.rawValue) {
                        selectedCatgory = eachCategory
                    }
                    .buttonStyle(FilterButtonStyle(color: eachCategory.color))
                }
            }
            .padding()
        }
        .background(Color.accentColor.opacity(0.8).edgesIgnoringSafeArea(.horizontal))
    }
}

struct CategoryFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryFilterView(selectedCatgory: .constant(.none))
    }
}
