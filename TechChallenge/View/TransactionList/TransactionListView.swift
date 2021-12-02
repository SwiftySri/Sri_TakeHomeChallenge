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
        VStack(spacing: 0) {
            CategoryFilterView(selectedCatgory: $viewmodel.selectedCategory)
            List() {
                ForEach(viewmodel.transactions) { transaction in
                    TransactionView(transaction: transaction, pinned: !viewmodel.ignoredTransactions.contains(transaction))
                        .onTapGesture {
                            togglePin(for: transaction)
                        }
                        .animation(.spring(), value: viewmodel.ignoredTransactions)
                }
            }
            SummaryView(selectedCatgory: $viewmodel.selectedCategory, sum: $viewmodel.displaySum)
        }
        .animation(.spring(), value: viewmodel.selectedCategory)
        .listStyle(PlainListStyle())
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Transactions")
    }
    
    private func togglePin(for txn: TransactionModel) {
        if viewmodel.ignoredTransactions.contains(txn) {
            viewmodel.ignoredTransactions.remove(txn)
        } else {
            viewmodel.ignoredTransactions.insert(txn)
        }
    }

}

#if DEBUG
struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
    }
}
#endif
