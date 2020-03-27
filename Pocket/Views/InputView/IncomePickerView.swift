//
//  IncomePickerView.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-01-31.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import SwiftUI

struct IncomePickerView: View {
//    @State var incomeSelection = Transaction.IncomeOutcome.withdrawal
    @Binding var incomeSelection : Transaction.IncomeOutcome
//
//    init(incomeSelection: Binding<Transaction.IncomeOutcome>) {
//        //UISegmentedControl.appearance().tintColor = UIColor.ligthBrownButtonBackgorund
//        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont(name: "HelveticaNeue-Medium", size: 16)!, .foregroundColor: UIColor.brown], for: .normal)
//    }

    var body: some View {
        Picker(selection: $incomeSelection, label: Text("")) {
            Text("Widrawal").tag(Transaction.IncomeOutcome.withdrawal)
                .accentColor(Color.init(UIColor.brown))
                .font(Font.custom("HelveticaNeue-Medium", size: 16))
            Text("Deposit").tag(Transaction.IncomeOutcome.deposit)
                .accentColor(Color.init(UIColor.brown))
        }
        .pickerStyle(SegmentedPickerStyle())
        .background(Color.init(UIColor.ligthBrownButtonBackgorund))
        .padding()
    }
}

//struct IncomePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        IncomePickerView()
//    }
//}
