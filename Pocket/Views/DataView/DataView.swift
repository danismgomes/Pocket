//
//  DataView.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-03-11.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import SwiftUI
import Firebase

struct DataView: View {
    
    @ObservedObject var session = FirebaseSession()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.brown]
    }
    
    var body: some View {
        NavigationView {
            Group {
                if session.session != nil {
                    List {
                        ForEach(self.session.transactions){ transaction in
                            TransactionRowView(transaction: transaction)
                        }
                    }
                } else {
                    LoginView()
                    .navigationBarItems(trailing: Text(""))
                }
                
            }
            .onAppear(perform: getUser)
            .navigationBarTitle(Text("Transactions"))
            .padding()
        }
    }
    
    func getUser() {
        self.session.listen()
    }
}
