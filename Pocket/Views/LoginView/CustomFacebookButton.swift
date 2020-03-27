//
//  CustomFacebookButton.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-01-22.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import FacebookLogin
import Firebase
import FirebaseAuth

struct CustomFacebookButton: UIViewRepresentable {
    
    func makeCoordinator() -> CustomFBButtonCoordinator {
        CustomFBButtonCoordinator(self)
    }
    
    
    func makeUIView(context: UIViewRepresentableContext<CustomFacebookButton>) -> UIButton {
        
        let customFBButton = UIButton()
        let imageName = "FacebookLogo"
        customFBButton.backgroundColor = .white
        if let image = UIImage(named: imageName){
            customFBButton.setImage(image, for: .normal)
        }
        customFBButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        customFBButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        customFBButton.translatesAutoresizingMaskIntoConstraints = false
        customFBButton.addTarget(context.coordinator, action: #selector(context.coordinator.customFBButtonPressed(_:)), for: .touchUpInside)
        
        return customFBButton
    }
    
    func updateUIView(_ uiView: UIButton, context: UIViewRepresentableContext<CustomFacebookButton>) {
        
    }
}

class CustomFBButtonCoordinator: NSObject {
    var parent: CustomFacebookButton
    
    init(_ parent: CustomFacebookButton) {
        self.parent = parent
    }
    
    @objc func customFBButtonPressed(_ sender: UIButton) {
        LoginManager().logIn(permissions: ["email"], from: UIApplication.shared.windows.last?.rootViewController) { (result, error) in
            
            if result?.isCancelled ?? false {
                return
            }
            
            if error != nil {
                print("FB Login failed: ", error.debugDescription)
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            let session = FirebaseSession()
            session.signInFacebook(authCredential: credential) { (res, er) in
                if er != nil {
                    print((er?.localizedDescription)!)
                    return
                }
                
            }
            print("Logged in with facebook ... ... ...")
           
        }
    }
}
