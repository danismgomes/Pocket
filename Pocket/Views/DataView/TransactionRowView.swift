//
//  TransactionRowView.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-03-17.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import SwiftUI

struct TransactionRowView: View {
    let transaction: Transaction
    
    var body: some View {
        HStack{
            Image("\(transaction.categoryType.rawValue)")
            
            VStack(alignment: .leading, spacing: 10) {
                Text("$ "+String(format: "%.02f", transaction.amount))
                    .font(.headline)
                    .foregroundColor(transaction.incomeOutcome.rawValue=="deposit" ? .green : .red)
                Text("Payment type: \(transaction.paymentType.rawValue.capitalizingFirstLetter())").font(.subheadline)
                Text("Date: \(transaction.date)").font(.subheadline)
            }
            .padding(.leading, 15)  // spacing from left edge of the view
            .padding(.trailing, 15) // spacing from right edge of the view
            .padding(.top, 5)
        }
        
    }
}
