//
//  LoginView.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-01-15.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import SwiftUI
import FBSDKLoginKit
import Firebase
import FirebaseAuth

struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    private let AppLogoImageName = "PocketLogo"
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30){
                Image(AppLogoImageName)
                    .frame(width: 320.0, height: 320.0)
                    .aspectRatio(contentMode: .fit)
                VStack(spacing: 20){
                    TextField("E-mail" , text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 45)
                        .font(Font.custom("Helvetica", size: 12))
                    TextField("Password" , text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 45)
                        .font(Font.custom("Helvetica", size: 12))
                }
                
//                NavigationLink(destination: MainView()) {
//                    Text("SIGN IN")
//                        .foregroundColor(Color.white)
//                        .font(Font.custom("HelveticaNeue-Medium", size: 16))
//                }
//                .frame(width: 105.0, height: 45.0)
//                .background(Color.init(UIColor.brown))
//                .cornerRadius(20)
                Button(action: logIn){
                    Text("SIGN IN")
                        .foregroundColor(Color.white)
                        .font(Font.custom("HelveticaNeue-Medium", size: 16))
                }
                .frame(width: 105.0, height: 45.0)
                .background(Color.init(UIColor.brown))
                .cornerRadius(20)
                
//                Button(action: {
//                    self.presentationMode.wrappedValue.dismiss()
//                }) {
//                    Text("CANCEL")
//                    .foregroundColor(Color.white)
//                    .font(Font.custom("HelveticaNeue-Medium", size: 16))
//                }
//                .frame(width: 105.0, height: 45.0)
//                .background(Color.init(UIColor.brown))
//                .cornerRadius(20)
            }
        }
    }
    
    //MARK: Functions
    func logIn() {
        session.logIn(email: email, password: password) { (result, error) in
            if error != nil {
                print("Error")
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
}




