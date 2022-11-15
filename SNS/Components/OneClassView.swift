//
//  OneClassView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct OneClassView: View {
    let lessonImageURLString: String
    let lessonName: String
    let userIconURLString: String
    let lessonBudgets: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
               
                    VStack(alignment: .leading){
                        WebImage(url: URL(string: lessonImageURLString)).resizable().frame(width: 125, height: 90)

                        Text(lessonName).frame(width: 115).font(.system(size: 11)).padding(.horizontal,5).foregroundColor(.black)
                        HStack{
                            WebImage(url: URL(string: userIconURLString)).resizable().frame(width:20, height: 20).clipShape(Circle())
                            Spacer()
                            Text("\(lessonBudgets)円").font(.footnote).foregroundColor(.black)
                        }.frame(width:115).padding(.bottom,5).padding(.horizontal,5)
                    }.background(.ultraThinMaterial).cornerRadius(5)
            }
        }
    }
}

struct OneClassView_Previews: PreviewProvider {
    static var previews: some View {
        OneClassView(lessonImageURLString: "", lessonName: "", userIconURLString: "", lessonBudgets: 0)
    }
}

struct LessonDeatil: Identifiable {
    let id = UUID()
    var lessonName: String
    var lessonImage: String
    var lessonPrice: String
    var lessonOwnerImage: String
}
