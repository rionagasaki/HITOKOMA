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
    var namespace: Namespace.ID
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(detailCategory.indices, id: \.self) { index in
                    Button {
                        withAnimation {
                            selection = index
                        }
                        if selection == 0 {
                            searchableLessonData = lessonData
                        }else {
                            searchableLessonData = lessonData.filter({
                                $0.category == detailCategory[selection].categoryName
                            })
                        }
                    } label: {
                        ZStack {
                            OneDetailCategoryView(
                                categoryImage: detailCategory[index].categoryImage,
                                categoryName: detailCategory[index].categoryName)
                            .frame(width:140, height: 90)
                            
                            if selection == index {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.customBlue, lineWidth: 3)
                                    .cornerRadius(8)
                                    .matchedGeometryEffect(id: "CustomButton", in: namespace)
                            }
                        }
                    }
                }
            }.padding(.horizontal,16)
        }
    }
}

struct DetailCategoryView_Previews: PreviewProvider {
    @State static var selection = 0
    @Namespace static var namespace
    @State static var lessonData: [LessonData] = []
    static var previews: some View {
        DetailCategoryView(detailCategory: [], lessonData: [], searchableLessonData: $lessonData, selection: $selection, namespace: namespace)
    }
}

struct DetailCategory: Identifiable{
    let id = UUID()
    let categoryName: String
    let categoryImage: String
}


struct OneDetailCategoryView: View {
    
    let categoryImage: String
    let categoryName: String
    
    var body: some View {
        VStack{
            Image(categoryImage).resizable().scaledToFit().frame(width: 120, height: 50)
            Text(categoryName).foregroundColor(.black).bold()
        }
    }
}
