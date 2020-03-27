//
//  GoogleLoginController.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-01-21.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn

struct GoogleLoginController: UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<GoogleLoginController>) -> GIDSignInButton {
        
        let googleButton = GIDSignInButton()
        googleButton.colorScheme = .dark
        
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return googleButton

    }

    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<GoogleLoginController>) {

    }
}
