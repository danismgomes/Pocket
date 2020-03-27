//
//  MainView.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-01-29.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            InputView()
                .tabItem {Text("Input")}
            
            DataView()
                .tabItem {(Text("Transactions"))}
            
            MainGraphView()
                .tabItem {Text("Graph")}
            
            SettingsView()
                .tabItem {Text("Settings")}
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
