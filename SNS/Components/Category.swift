//
//  Janlu.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/17.
//

import SwiftUI

struct Category: View {
    let categoryText: String
    let categoryImage:String
    var body: some View {
        ZStack{
            VStack{
                Image(categoryImage).resizable().frame(width: 60, height: 60).background(.ultraThinMaterial).cornerRadius(50).shadow(radius: 10, x: 5, y: 5)
                Text(categoryText).foregroundColor(.black).font(.system(size: 13))
            }
        }
    }
}

struct Janlu_Previews: PreviewProvider {
    static var previews: some View {
        Category(categoryText: "学ぶ", categoryImage: "study")
    }
}
