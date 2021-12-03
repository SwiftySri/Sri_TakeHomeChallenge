//
//  TransactionsViewModel.swift
//  TechChallenge
//
//  Created by Srinidhi on 12/1/21.
//

import Foundation

class TransactionsViewModel: ObservableObject {
    
    // MARK: Public
    // variables for user displayed values for views to access
    var transactionsTotal: Double = 0.0
    
    @Published var listTotal: Double = 0.0
    @Published var categoryTotalMap: [TransactionModel.Category: Double] = [:]
    @Published var ignoredTransactions: Set<TransactionModel> = [] {
        didSet {
            computeSum()
            computeCategorySum()
        }
    }
    @Published var selectedCategory: TransactionModel.Category? {
        didSet {
            if let chosenCategory = selectedCategory {
                transactions = allTransactions.filter { $0.category == chosenCategory }
            } else {
                transactions = allTransactions
            }
            computeSum()
        }
    }

    // MARK: Private
    private (set) var transactions: [TransactionModel]
    private let allTransactions: [TransactionModel]
    
    // MARK: Public Init
    // (To make it fully testable)
    init(transactions: [TransactionModel] = ModelData.sampleTransactions) {
        self.transactions = transactions
        self.allTransactions = transactions
        self.ignoredTransactions = []
    }
    
    // MARK: Private conveinence functions
    private func computeSum() {
        listTotal = aggregateSum(for: transactions)
        transactionsTotal = aggregateSum(for: allTransactions)
    }
        
    private func computeCategorySum() {
        let groupedTxns = Dictionary(grouping: allTransactions) { $0.category }
        groupedTxns.forEach { categoryTotalMap[$0] = aggregateSum(for: $1) }
    }
    
    private func aggregateSum(for inputTxns: [TransactionModel]) -> Double {
        Set(inputTxns).subtracting(ignoredTransactions).reduce(0.0) { $0 + $1.amount }
    }
}

extension Double {
    /// Helper function to format double to displayable currency
    /// TODO: Consider localization
    var currencyFormat: String {
        String(format: "$%.2f", self)
    }
}
