//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionListView: View {
    @StateObject private var viewmodel = TransactionListViewModel()
    
    var body: some View {
        VStack {
            CategoryFilterView(selectedCatgory: $viewmodel.selectedCategory)
            List {
                ForEach(viewmodel.transactions) { transaction in
                    TransactionView(transaction: transaction)
                }
            }
            SummaryView(selectedCatgory: $viewmodel.selectedCategory, sum: $viewmodel.displaySum)
        }
        .animation(.easeIn, value: viewmodel.transactions.count)
        .listStyle(PlainListStyle())
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Transactions")
    }
}

#if DEBUG
struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
    }
}
#endif
