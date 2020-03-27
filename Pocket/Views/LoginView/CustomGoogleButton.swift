//
//  CustomGoogleButton.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-01-22.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn


struct CustomGoogleButton: UIViewRepresentable {
    
    func makeCoordinator() -> CustomGoogleButtonCoordinator {
        CustomGoogleButtonCoordinator(self)
    }
    
    
    func makeUIView(context: UIViewRepresentableContext<CustomGoogleButton>) -> UIButton {
        
        let customGoogleButton = UIButton()
        let imageName = "GoogleLogo"
        customGoogleButton.backgroundColor = .white
        if let image = UIImage(named: imageName){
            customGoogleButton.setImage(image, for: .normal)
        }
        customGoogleButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        customGoogleButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        customGoogleButton.translatesAutoresizingMaskIntoConstraints = false
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        customGoogleButton.addTarget(context.coordinator, action: #selector(context.coordinator.customGoogleButtonPressed(_:)), for: .touchUpInside)
        
        return customGoogleButton
    }
    
    func updateUIView(_ uiView: UIButton, context: UIViewRepresentableContext<CustomGoogleButton>) {
        
    }
}

class CustomGoogleButtonCoordinator: NSObject {
    var parent: CustomGoogleButton
    
    init(_ parent: CustomGoogleButton) {
        self.parent = parent
    }
    
    @objc func customGoogleButtonPressed(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
}
