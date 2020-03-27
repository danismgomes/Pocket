//
//  AppRootView.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-01-17.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct AppRootView: View {
    
    //@ObservedObject var user : UserController
    @ObservedObject var session : FirebaseSession
    
    func getUser () {
        session.listen()
    }

    
    var body: some View {
        Group {
            if session.session != nil {
                MainView()
            } else {
                LoginView()
            }
        }.onAppear(perform: getUser)
    
    }
}

struct AppRootView_Previews: PreviewProvider {
    static var previews: some View {
        AppRootView(session: FirebaseSession())
    }
}
