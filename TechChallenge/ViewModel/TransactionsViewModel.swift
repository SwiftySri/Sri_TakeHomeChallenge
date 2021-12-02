//
//  TransactionsViewModel.swift
//  TechChallenge
//
//  Created by Srinidhi on 12/1/21.
//

import Foundation

class TransactionsViewModel: ObservableObject {
    
    private (set) var transactions: [TransactionModel] = ModelData.sampleTransactions
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
                transactions = ModelData.sampleTransactions.filter {
                    $0.category == chosenCategory
                }
            } else {
                transactions = ModelData.sampleTransactions
            }
            computeSum()
        }
    }
    
    init() {
        computeSum()
        computeCategorySum()
    }
    
    private func computeSum() {
        listTotal = aggregateSum(for: transactions)
        transactionsTotal = aggregateSum(for: ModelData.sampleTransactions)
    }
        
    private func computeCategorySum() {
        let groupedTxns = Dictionary(grouping: ModelData.sampleTransactions) { $0.category }
        groupedTxns.forEach { categoryTotalMap[$0] = aggregateSum(for: $1) }
    }
    
    private func aggregateSum(for inputTxns: [TransactionModel]) -> Double {
        Set(inputTxns).subtracting(ignoredTransactions).reduce(0.0) { $0 + $1.amount }
    }
}

extension Double {
    var currencyFormat: String {
        String(format: "$%.2f", self)
    }
}
