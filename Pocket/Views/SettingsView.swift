//
//  Settings.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-01-31.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    //@State var user = UserController()
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
        Form {
            Button(action: session.logOut)  {
                Text("Logout")
                    .foregroundColor(Color.white)
                    .font(Font.custom("HelveticaNeue-Medium", size: 20))
                }
                .frame(width: 105.0, height: 45.0)
                .background(Color.init(UIColor.brown))
                .cornerRadius(20)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
