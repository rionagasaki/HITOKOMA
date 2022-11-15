//
//  DetailCategoryView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/06.
//

import SwiftUI

struct DetailCategoryView: View {
    
    let englishDetails = [DetailCategory(categoryName: "TOEIC", categoryImage: "TOEIC"),DetailCategory(categoryName: "TOEFL", categoryImage: "TOEFL"),DetailCategory(categoryName: "英検", categoryImage: "EnglishTest")]
    
    let computerDetails = [DetailCategory(categoryName: "基本/応用情報", categoryImage: "basicInformation"), DetailCategory(categoryName: "プログラミング", categoryImage: "programming"), DetailCategory(categoryName: "G/E資格", categoryImage: "AI")
    ]
    
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
