//
//  InputView.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-01-16.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import SwiftUI
import Firebase

struct InputView: View {
    var ref: DatabaseReference! = Database.database().reference()
    @State private var activeAlert: ActiveAlert = .empty
    @State private var doneAlert = false
    @State private var cleanAlert = false
    @State var showCategories = false
    @State var inputValue : String = ""
    @State var isEdited = false
    @State var paymentSelected = Transaction.PaymentType.none
    @State var incomeSelection = Transaction.IncomeOutcome.withdrawal
    @State var categorySelected = Transaction.CategoryType.none
    
    @ObservedObject var session = FirebaseSession()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }
    
    var tapStopEditing: some Gesture {
    TapGesture().onEnded({
            UIApplication.shared.windows.first{$0.isKeyWindow }?.endEditing(true)})
    }

    var body: some View {
        Background {
            VStack() {
                TextField("$", text: self.$inputValue, onEditingChanged: { isEdited in
                            self.isEdited = isEdited
                    })
                    .font(Font.custom("HelveticaNeue-CondensedBold", size: 55))
                    .foregroundColor(Color.init(UIColor.brown))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding(.top, 100)
                    .padding()
                HStack{
                    VStack{
                        Text("Category:")
                            .font(Font.custom("HelveticaNeue-CondensedBold", size: 20))
                            .foregroundColor(Color.init(UIColor.brown))
                        
                        Button(action: {
                            self.showCategories.toggle()
                        }) {
                            Image(self.categorySelected.rawValue)
                                .renderingMode(.original)
                        }
                        .sheet(isPresented: self.$showCategories) { CategoriesView(showCategories: self.$showCategories, categorySelected: self.$categorySelected) }
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width / 2)
                    .clipped()
                        
                    VStack{
                        Text("Payment method:")
                            .font(Font.custom("HelveticaNeue-CondensedBold", size: 20))
                            .foregroundColor(Color.init(UIColor.brown))
                        Picker(selection: self.$paymentSelected, label: Text("")) {
                            Text("None").tag(Transaction.PaymentType.none)
                                .font(Font.custom("HelveticaNeue-Light", size: 16))
                                .foregroundColor(Color.init(UIColor.brown))
                            
                            Text("Debit Card").tag(Transaction.PaymentType.debit)
                                .font(Font.custom("HelveticaNeue-Light", size: 16))
                                .foregroundColor(Color.init(UIColor.brown))
                            
                            Text("Credit Card").tag(Transaction.PaymentType.credit)
                                .font(Font.custom("HelveticaNeue-Light", size: 16))
                                .foregroundColor(Color.init(UIColor.brown))
                            
                            Text("Cash").tag(Transaction.PaymentType.cash)
                                .font(Font.custom("HelveticaNeue-Light", size: 16))
                                .foregroundColor(Color.init(UIColor.brown))
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 60)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width / 2)
                    .clipped()
                }
                IncomePickerView(incomeSelection: self.$incomeSelection)
            }
            HStack{
                VStack(){
                    Button(action: {
                        self.inputValue = ""
                        self.categorySelected = Transaction.CategoryType.none
                        self.paymentSelected = Transaction.PaymentType.none
                        self.incomeSelection = Transaction.IncomeOutcome.withdrawal
                        self.cleanAlert = true
                    }) {
                        Text("Clean")
                            .foregroundColor(Color.white)
                            .font(Font.custom("HelveticaNeue-Medium", size: 20))
                    }
                    .frame(width: 105.0, height: 30.0)
                    .background(Color.init(UIColor.brown))
                    .cornerRadius(15)
                    .padding()
        
                }
                .alert(isPresented: self.$cleanAlert) {
                    Alert(title: Text("Clean"), message: Text("You cleaned all fields of your transaction"), dismissButton: .default(Text("Ok")))
                }
                Spacer()
                VStack(){
                    Button(action: self.addTransaction) {
                        Text("Done")
                            .foregroundColor(Color.white)
                            .font(Font.custom("HelveticaNeue-Medium", size: 20))
                    }
                    .frame(width: 105.0, height: 30.0)
                    .background(Color.init(UIColor.brown))
                    .cornerRadius(15)
                    .padding()
                }
                .alert(isPresented: self.$doneAlert) {
                    switch self.activeAlert {
                    case .done:
                        return Alert(title: Text("Done"), message: Text("You add a new transaction :)"), dismissButton: .default(Text("Ok")))
                    case .empty:
                        return  Alert(title: Text("Empty Field!"), message: Text("Please add a value to the transaction!"), dismissButton: .default(Text("Ok")))
                    }
                }
            }
            Spacer()
            
        }
        .gesture(self.tapStopEditing, including: self.isEdited ? .all : .subviews)
    }
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    func addTransaction(){
        if !inputValue.isEmpty {
            session.uploadTransactions(amount: inputValue, paymentType: paymentSelected.rawValue, categoryType: categorySelected.rawValue, incomeOutcome: incomeSelection.rawValue, date: dateFormatter.string(from: Date()))
            self.activeAlert = .done
            self.inputValue = ""
        } else {
            self.activeAlert = .empty
        }
        self.doneAlert  = true
        
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct Background<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        Color.white
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .overlay(content)
    }
    
}

enum ActiveAlert {
    case done, empty
}


