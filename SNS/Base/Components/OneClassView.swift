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
    @State var filled = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment: .top){
                    VStack(alignment: .leading, spacing: 0){
                        ZStack(alignment: .bottomTrailing) {
                            WebImage(url: URL(string: lessonImageURLString)).resizable()
                                .placeholder {
                                    Rectangle().frame(width: 120, height: 90).foregroundColor(.customLightGray)
                                    }
                                .transition(.flipFromBottom(duration: 10))
                                .scaledToFill()
                                .frame(width: 120, height: 90)
                            
                            Button {
                                filled.toggle()
                            } label: {
                                Image(systemName: filled ? "heart.fill": "heart")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .padding(.all, 4)
                                    .background(Color.white.opacity(0.5))
                                    .clipShape(Circle())
                                    .foregroundColor(filled ? .customRed2: .customGray)
                                    .padding(.trailing, 3)
                                    .padding(.bottom, 3)
                            }

                        }
                        HStack(alignment: .top){
                            Text(lessonName).font(.system(size: 10)).font(.subheadline).lineLimit(3).foregroundColor(.black).multilineTextAlignment(.leading).padding(.top,5)
                            Spacer()
                        }.frame(width: 120)
                        Spacer()
                        HStack{
                            WebImage(url: URL(string: userIconURLString)).resizable().frame(width:20, height: 20).clipShape(Circle())
                            Spacer()
                            Text("\(lessonBudgets)円").font(.footnote).foregroundColor(.black)
                        }.frame(width:120)
                    }.frame(height: 150)
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
