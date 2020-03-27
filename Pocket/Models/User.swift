//
//  User.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-01-15.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import SwiftUI
import Firebase

class User: Identifiable {
    
    var uid: String?
    var email: String?
    var displayName: String?
    var transactions: [Transaction] = []

    init(uid: String?, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}
