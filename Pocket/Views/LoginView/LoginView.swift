//
//  LoginView.swift
//  
//
//  Created by Danielle Gomes on 2020-01-20.
//

import SwiftUI

struct LoginView: View {
    
    private let AppLogoImageName = "PocketLogo"
    private let googleButtonImageName = "GoogleLogo"
    private let facebookButtonImageName = "FacebookLogo"
    private let appleButtonImageName = "AppleLogo"
    @State private var showSignInModal = false
    @State private var showSignUpModal = false
    @EnvironmentObject var session: FirebaseSession

    var body: some View {
        NavigationView {
            VStack(spacing: 30){
                Image(AppLogoImageName)
                    .frame(width: 320.0, height: 320.0)
                    .aspectRatio(contentMode: .fit)
                
                NavigationLink(destination: SignInView()) {
                    Text("SIGN IN")
                    .foregroundColor(Color.white)
                    .font(Font.custom("HelveticaNeue-Medium", size: 16))
                }
                .frame(width: 105.0, height: 45.0)
                .background(Color.init(UIColor.brown))
                .cornerRadius(20)
                
                NavigationLink(destination: SignUpView()) {
                    Text("SIGN UP")
                    .foregroundColor(Color.white)
                    .font(Font.custom("HelveticaNeue-Medium", size: 16))
                }
                .frame(width: 105.0, height: 45.0)
                .background(Color.init(UIColor.brown))
                .cornerRadius(20)
                
                Divider()
                    .padding(.horizontal, 45)
                    .foregroundColor(Color.init(UIColor.brown))
                
                VStack(spacing: 10) {
                    Text("or use social login")
                        .font(Font.custom("Helvetica", size: 12))
                        .foregroundColor(Color.gray)
                    
                    HStack(spacing: 10){
                        CustomFacebookButton().frame(width: 45, height: 45)
                        CustomGoogleButton().frame(width: 45, height: 45)
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
