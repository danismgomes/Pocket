//
//  Transaction.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-01-15.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import SwiftUI
import Firebase

struct Transaction: Identifiable {
    
    var ref: DatabaseReference?// = Database.database().reference()
    let key: String
    let id : String
    let amount: Double
    let paymentType: Transaction.PaymentType
    let categoryType: Transaction.CategoryType
    let incomeOutcome: Transaction.IncomeOutcome
    let date: Date
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }
    
    enum IncomeOutcome: String, CaseIterable, Codable, Hashable {
        case withdrawal
        case deposit
    }
    
    enum PaymentType: String, CaseIterable, Codable, Hashable {
        case none
        case cash
        case debit
        case credit
    }
    
    enum CategoryType: String, CaseIterable, Codable, Hashable{
        case none
        case grocery
        case restaurant
        case coffe
        case trasportation
        case shopping
        case pub
        case gift
    }

    
    init(amount: Double, paymentType: Transaction.PaymentType, categoryType: Transaction.CategoryType, incomeOutcome: Transaction.IncomeOutcome, date: Date, key: String = "") {
        self.ref = nil
        self.key = key
        self.amount = amount.truncate(places: 2)
        self.paymentType = paymentType
        self.categoryType = categoryType
        self.incomeOutcome = incomeOutcome
        self.id = key
        self.date = date
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let amount = value["amount"] as? String,
            let paymentType = value["paymentType"] as? String,
            let categoryType = value["categoryType"] as? String,
            let incomeOutcome = value["incomeOutcome"] as? String,
            let date = value["date"] as? String
            else {
                return nil
            }
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return formatter
        }
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.amount = Double(amount) ?? 0.00
        self.paymentType = Transaction.PaymentType(rawValue: paymentType) ?? Transaction.PaymentType.none
        self.categoryType = Transaction.CategoryType(rawValue: categoryType)  ?? Transaction.CategoryType.none
        self.incomeOutcome = Transaction.IncomeOutcome(rawValue: incomeOutcome) ?? Transaction.IncomeOutcome.withdrawal
        self.date = dateFormatter.date(from: date) ?? Date()
        self.id = snapshot.key
    }
    
    func toAnyObject() -> Any {
        
        return [
            "amount": String(amount),
            "paymentType": paymentType.rawValue,
            "categoryType": categoryType.rawValue,
            "incomeOutcome": incomeOutcome.rawValue,
            "date": dateFormatter.string(from: date)
        ]
    }
    
}

#if DEBU
//let testData =  [
//    Transaction(amount: 20.00, isIncome: true, paymentType: Transaction.PaymentType.none, categoryType: Category(type: "none"), incomeOutcome: Transaction.IncomeOutcome.withdrawal),
//    Transaction(amount: 128920.00, isIncome: true, paymentType: Transaction.PaymentType.cash, categoryType: Category(type: "none"), incomeOutcome: Transaction.IncomeOutcome.withdrawal),
//    Transaction(amount: 714, isIncome: true, paymentType: Transaction.PaymentType.cash, categoryType: Category(type: "none"), incomeOutcome: Transaction.IncomeOutcome.withdrawal),
//    Transaction(amount: 900.8762, isIncome: true, paymentType: Transaction.PaymentType.cash, categoryType: Category(type: "none"), incomeOutcome: Transaction.IncomeOutcome.withdrawal),
//    Transaction(amount: 919191919191, isIncome: true, paymentType: Transaction.PaymentType.cash, categoryType: Category(type: "none"), incomeOutcome: Transaction.IncomeOutcome.withdrawal),
//    Transaction(amount: 1, isIncome: true, paymentType: Transaction.PaymentType.cash, categoryType: Category(type: "none"), incomeOutcome: Transaction.IncomeOutcome.withdrawal),
    //Transaction(amount: "0", paymentType: Transaction.PaymentType.cash, categoryType: Category(type: "none"), incomeOutcome: Transaction.IncomeOutcome.withdrawal),
//]
#endif


