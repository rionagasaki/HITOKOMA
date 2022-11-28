//
//  DetailCategoryView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/06.
//

import SwiftUI

struct DetailCategoryView: View {
    @State var detailCategory: [DetailCategory]
    @State var selection: Int
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(detailCategory.indices) { index in
                    Button {
                        selection = index
                    } label: {
                        VStack{
                            Image(detailCategory[index].categoryImage).resizable().scaledToFit().frame(width: 120, height: 50)
                            Text(detailCategory[index].categoryName).foregroundColor(.black).bold()
                        }.frame(width:140, height: 90).background(RoundedRectangle(cornerRadius: 8).stroke(selection == index ? .green: .black, lineWidth: selection == index ? 3 : 1.5)).cornerRadius(8)
                    }
                }
            }.padding(.horizontal,16)
        }
    }
}

struct DetailCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCategoryView(detailCategory: [], selection: 0)
    }
}

struct DetailCategory: Identifiable{
    let id = UUID()
    let categoryName: String
    let categoryImage: String
}
