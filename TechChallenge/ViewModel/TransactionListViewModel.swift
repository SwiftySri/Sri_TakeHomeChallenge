//
//  TransactionListViewModel.swift
//  TechChallenge
//
//  Created by Srinidhi on 12/1/21.
//

import Foundation

class TransactionListViewModel: ObservableObject {
    
    private (set) var transactions: [TransactionModel] = ModelData.sampleTransactions
    
    @Published var ignoredTransactions: Set<TransactionModel> = [] {
        didSet { computeSum() }
    }

    @Published var selectedCategory: TransactionModel.Category? {
        didSet {
            if let chosenCategory = selectedCategory {
                transactions = ModelData.sampleTransactions.filter {
                    $0.category == chosenCategory
                }
            } else {
                transactions = ModelData.sampleTransactions
            }
            computeSum()
        }
    }
    
    @Published var displaySum: String = ""
    
    init() {
        computeSum()
    }
    
    private func computeSum() {
        var runningSum = 0.0
        let unpinnedTransactions = Set(transactions).subtracting(ignoredTransactions)
        runningSum = unpinnedTransactions.reduce(0.0) { $0 + $1.amount }
        displaySum = String(format: "$%.2f", runningSum)
    }
}
