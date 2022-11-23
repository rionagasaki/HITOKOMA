//
//  DetailCategoryView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/06.
//

import SwiftUI

struct DetailCategoryView: View {
    @State var detailCategory: [DetailCategory]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(detailCategory) { detail in
                    Button {
                        print("aaaa")
                    } label: {
                        VStack{
                            Image(detail.categoryImage).resizable().scaledToFit().frame(width:140, height: 90).cornerRadius(10)
                            Text(detail.categoryName).foregroundColor(.black).bold()
                        }.background(.white).overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 1))
                    }
                }
            }.padding(.horizontal,16)
        }
    }
}

struct DetailCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCategoryView(detailCategory: [])
    }
}

struct DetailCategory: Identifiable{
    let id = UUID()
    let categoryName: String
    let categoryImage: String
}
