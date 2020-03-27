//
//  CategoryButtons.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-01-29.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import SwiftUI

struct CategoriesView: View {
    @Binding var showCategories: Bool
    @Binding var categorySelected: Transaction.CategoryType
    
    var body: some View {
        
        VStack(spacing: 60){
            Text("Select one category: ")
                .font(Font.custom("Helvetica", size: 55))
                .foregroundColor(Color.init(UIColor.brown))
            
            HStack(spacing: 60){
            
                CategoryButton(category: Transaction.CategoryType.none, showCategories: $showCategories, categorySelected: $categorySelected)
                
                CategoryButton(category: Transaction.CategoryType.coffe, showCategories: $showCategories, categorySelected: $categorySelected)
                
                CategoryButton(category: Transaction.CategoryType.gift, showCategories: $showCategories, categorySelected: $categorySelected)
                
                CategoryButton(category: Transaction.CategoryType.grocery, showCategories: $showCategories, categorySelected: $categorySelected)
            }
            
            HStack(spacing: 60){
                CategoryButton(category: Transaction.CategoryType.pub, showCategories: $showCategories, categorySelected: $categorySelected)
                
                CategoryButton(category: Transaction.CategoryType.restaurant, showCategories: $showCategories, categorySelected: $categorySelected)
                
                CategoryButton(category: Transaction.CategoryType.trasportation, showCategories: $showCategories, categorySelected: $categorySelected)
                
                CategoryButton(category: Transaction.CategoryType.shopping, showCategories: $showCategories, categorySelected: $categorySelected)
            }
            
            Button(action: {
                self.showCategories.toggle()
            }) {
                Text("Cancel")
            }
        
        }
    }
}
