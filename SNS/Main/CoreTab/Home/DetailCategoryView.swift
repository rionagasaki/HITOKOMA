//
//  DetailCategoryView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/06.
//

import SwiftUI

struct DetailCategoryView: View {
    let detailCategory: [DetailCategory]
    let lessonData: [LessonData]
    @Binding var searchableLessonData: [LessonData]
    @Binding var selection: Int
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(detailCategory.indices, id: \.self) { index in
                    Button {
                        selection = index
                        if selection == 0 {
                            self.searchableLessonData = self.lessonData
                        }else{
                            self.searchableLessonData = self.lessonData.filter({ 
                                $0.category == detailCategory[selection].categoryName
                            })
                        }
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
    @State static var selection = 0
    @State static var lessonData: [LessonData] = []
    static var previews: some View {
        DetailCategoryView(detailCategory: [], lessonData: [], searchableLessonData: $lessonData, selection: $selection)
    }
}

struct DetailCategory: Identifiable{
    let id = UUID()
    let categoryName: String
    let categoryImage: String
}
