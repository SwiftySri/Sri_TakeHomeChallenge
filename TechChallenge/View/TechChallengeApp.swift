//
//  TechChallengeApp.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

@main
struct TechChallengeApp: App {

    private let txnVM = TransactionsViewModel()

    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    TransactionListView(viewmodel: txnVM)
                }
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
                
                NavigationView {
                    InsightsView(viewmodel: txnVM)
                }
                .tabItem {
                    Label("Insights", systemImage: "chart.pie.fill")
                }
            }
        }
    }
}
