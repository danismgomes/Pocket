//
//  CategoryButton.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-01-29.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import SwiftUI

struct CategoryButton: View {
    
    @State var category: Transaction.CategoryType
    @Binding var showCategories: Bool
    @Binding var categorySelected: Transaction.CategoryType
    
    var body: some View {
        Button(action: {
            self.categorySelected = self.category
            self.showCategories.toggle()
        }) {
            Image(category.rawValue)
                .renderingMode(.original)
        }
        .frame(width: 25, height: 25)
    }
}
