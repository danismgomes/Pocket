//
//  FirebaseSession.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-03-16.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase

class FirebaseSession: ObservableObject {
    
    //MARK: Properties
    @Published var session: User?
    @Published var isLoggedIn: Bool?
    @Published var transactions: [Transaction] = []

    var ref: DatabaseReference! = Database.database().reference()
    
    //MARK: Functions
    func listen() {
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.session = User(uid: user.uid, displayName: user.displayName, email: user.email)
                self.isLoggedIn = true
                self.getTransactions()
            } else {
                self.isLoggedIn = false
                self.session = nil
            }
        }
    }
    
    func logIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func logOut () {
        do {
            try Auth.auth().signOut().self
//            if facebookAccessToken != nil {
//                facebookLoginManager.logOut()
//            }
            self.session = nil
            self.isLoggedIn = false
            print("Logged Out")
        } catch {
            print("Logout Error")
        }
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func getTransactions(){
        
        let userID = Auth.auth().currentUser?.uid ?? ""
        
        let getRef = ref.child("users").child(userID)
        
        getRef.observe(DataEventType.value) { (snapshot) in
            self.transactions = []
            for transaction in snapshot.children {
                if let snapshot = transaction as? DataSnapshot,
                let aTransaction = Transaction(snapshot: snapshot)
                {
                    self.transactions.append(aTransaction)
                }
            }
        }
    }
    
    func uploadTransactions(amount: String, paymentType: String, categoryType: String, incomeOutcome: String, date: String) {
        
        guard let postRef = ref.child("users").child((Auth.auth().currentUser?.uid ?? "user nil")).child("transactions").childByAutoId().key else {return}
        
        let aDouble = Double(amount)!
        
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return formatter
        }
        
        let post = Transaction(amount: aDouble, paymentType: Transaction.PaymentType(rawValue: paymentType)!, categoryType: Transaction.CategoryType(rawValue: categoryType)!, incomeOutcome: Transaction.IncomeOutcome(rawValue: incomeOutcome)!, date: dateFormatter.date(from: date)!).toAnyObject()
        
        let childUpdate = ["/users/\(String(describing: Auth.auth().currentUser?.uid ?? "user nil"))/\(postRef)/": post]
        
        ref.updateChildValues(childUpdate)
        
    }
    
    
    //corrigir
    func updateTransactions(key: String, todo: String, isComplete: String) {
        let update = ["todo": todo, "isComplete": isComplete]
        let childUpdate = ["\(key)": update]
        ref.updateChildValues(childUpdate)
    }
    
    func signInGoogle(
        authCredential: AuthCredential,
        handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(with: authCredential, completion: handler)
    }
    
    func signInFacebook(
        authCredential: AuthCredential,
        handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(with: authCredential, completion: handler)
    }
    
}
