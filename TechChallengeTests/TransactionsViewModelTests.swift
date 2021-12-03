//
//  TransactionsViewModelTests.swift
//  TechChallengeTests
//
//  Created by Srinidhi on 12/2/21.
//

import XCTest
@testable import TechChallenge

class TransactionsViewModelTests: XCTestCase {
    
    private var viewModel: TransactionsViewModel!

    override func setUpWithError() throws {
        viewModel = TransactionsViewModel(transactions: TestModelData.testTransactions)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testInit() throws {
        // Check initial values
        XCTAssertEqual(viewModel.selectedCategory, nil)
        XCTAssertEqual(viewModel.transactions.count, 13)
        XCTAssertEqual(viewModel.transactionsTotal.currencyFormat, "$472.08")
        XCTAssertEqual(viewModel.listTotal.currencyFormat, "$472.08")
        XCTAssertEqual(viewModel.ignoredTransactions.count, 0)
        XCTAssertEqual(viewModel.categoryTotalMap[.food]?.currencyFormat, "$74.28")
        XCTAssertEqual(viewModel.categoryTotalMap[.health]?.currencyFormat, "$21.53")
        XCTAssertEqual(viewModel.categoryTotalMap[.entertainment]?.currencyFormat, "$82.99")
        XCTAssertEqual(viewModel.categoryTotalMap[.shopping]?.currencyFormat, "$78.00")
        XCTAssertEqual(viewModel.categoryTotalMap[.travel]?.currencyFormat, "$215.28")
    }
    
    func testApplyCategoryFilterFood() {
        // Validate the case when a category filter is applied - food
        viewModel.selectedCategory = .food
        // Verify the list total displayed
        XCTAssertEqual(viewModel.listTotal.currencyFormat, "$74.28")
        // Ensure list does not contain any other category tansactions
        let filterDisplayedNonFoodTxn = viewModel.transactions.filter { $0.category != .food }
        XCTAssert(filterDisplayedNonFoodTxn.isEmpty)
    }
    
    
    func testApplyCategoryFilterShopping() {
        // Validate the case when a category filter is applied - shopping
        viewModel.selectedCategory = .shopping
        // Verify the list total displayed
        XCTAssertEqual(viewModel.listTotal.currencyFormat, "$78.00")
        // Ensure list does not contain any other category tansactions
        let filterDisplayedNonShoppingTxn = viewModel.transactions.filter { $0.category != .shopping }
        XCTAssert(filterDisplayedNonShoppingTxn.isEmpty)
    }
    
    func testUnpinPinAction() {
        // Unpin a transaction and ensure it is ignored from totals
        let txnToPin = viewModel.transactions[3]
        // Cache category total
        let categoryTotalCache = viewModel.categoryTotalMap[txnToPin.category]
        viewModel.ignoredTransactions = [txnToPin]
        
        // Check the list total without category filter
        let listTotal = 472.08 - txnToPin.amount
        XCTAssertEqual(viewModel.listTotal.currencyFormat, listTotal.currencyFormat)

        // Check the list total with category filter
        viewModel.selectedCategory = txnToPin.category
        let categoryListTotal = (categoryTotalCache ?? 0.0) - txnToPin.amount
        XCTAssertEqual(viewModel.listTotal.currencyFormat, categoryListTotal.currencyFormat)

        // Pin the transaction back and revalidate
        viewModel.ignoredTransactions = []
        XCTAssertEqual(viewModel.listTotal.currencyFormat, (categoryTotalCache ?? 0.0).currencyFormat)

        // Clear the filter
        viewModel.selectedCategory = nil
        XCTAssertEqual(viewModel.listTotal.currencyFormat, "$472.08")
    }
}


