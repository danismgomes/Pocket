//
//  StringExtention.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-03-25.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
