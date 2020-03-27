//
//  SignUpView.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-01-17.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    private let AppLogoImageName = "PocketLogo"
    
    @EnvironmentObject var session: FirebaseSession
    
    //@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                    TextField("Confirm Password" , text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 45)
                    .font(Font.custom("Helvetica", size: 12))
                }
                
                Button(action: signUp) {
                    Text("Sign Up")
                        .foregroundColor(Color.white)
                        .font(Font.custom("HelveticaNeue-Medium", size: 16))
                }
                .frame(width: 105.0, height: 45.0)
                .background(Color.init(UIColor.brown))
                .cornerRadius(20)
                
//                NavigationLink(destination: MainView()) {
//                    Text("SIGN UP")
//                        .foregroundColor(Color.white)
//                        .font(Font.custom("HelveticaNeue-Medium", size: 16))
//                }
//                .frame(width: 105.0, height: 45.0)
//                .background(Color.init(UIColor.brown))
//                .cornerRadius(20)
                
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
    
    func signUp() {
        if !email.isEmpty && !password.isEmpty {
            session.signUp(email: email, password: password) { (result, error) in
                if error != nil {
                    print("Error")
                } else {
                    self.email = ""
                    self.password = ""
                }
            }
        }
    }
}
