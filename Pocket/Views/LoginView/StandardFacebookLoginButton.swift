//
//  StandardFacebookLoginButton.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-01-21.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import Foundation
import SwiftUI
import FacebookLogin
import Firebase
import FirebaseAuth

struct StandardFacebookLoginButton: UIViewRepresentable {
    
    func makeCoordinator() -> StandardFacebookLoginButton.Coordinator {
        return StandardFacebookLoginButton.Coordinator()
    }
    
    func makeUIView(context: UIViewRepresentableContext<StandardFacebookLoginButton>) -> FBLoginButton {
        let facebookButton = FBLoginButton()
        facebookButton.permissions = ["email"]
        facebookButton.delegate = context.coordinator
        return facebookButton
    }
    
    func updateUIView(_ uiView: FBLoginButton, context: UIViewRepresentableContext<StandardFacebookLoginButton>) {
        
    }
    
    class Coordinator: NSObject, LoginButtonDelegate {
        
        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            
            if error != nil {
                print((error?.localizedDescription)!)
            }
            
            if AccessToken.current != nil {
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                let session = FirebaseSession()
                session.signInFacebook(authCredential: credential) { (res, er) in
                    if er != nil {
                        print((er?.localizedDescription)!)
                        return
                    }
                    
                }
            }
            
        }
        
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            try! Auth.auth().signOut()
        }
        
    }
}
