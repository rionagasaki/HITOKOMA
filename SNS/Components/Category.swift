//
//  Janlu.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/17.
//

import SwiftUI

struct Category: View {
    let category: CategoryData
    var body: some View {
        ZStack{
            VStack{
                Image(category.categoryImage).resizable().scaledToFit().frame(width: 60, height: 60).background(.ultraThinMaterial).cornerRadius(50).shadow(radius: 10, x: 5, y: 5)
                Text(category.categoryName).foregroundColor(.black).font(.system(size: 13))
            }
        }
    }
}
