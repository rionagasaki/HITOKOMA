//
//  OneRequestView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct OneRequestView: View {
    let request: RequestData
    
    var body: some View {
        VStack(spacing: .zero){
            
            ZStack(alignment: .topLeading){
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                    .frame(width: (UIScreen.main.bounds.width/2)-40)
                    
                VStack(alignment: .leading){
                    HStack{
                        ZStack(alignment: .topLeading){
                            WebImage(url: URL(string: request.userImageIconURL))
                                .resizable()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                                .background {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 40)
                                }
                                
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.black).background(.white)
                                .cornerRadius(60)
                                .overlay(Circle().stroke(.white, lineWidth: 1))
                        }
                        Text(request.username)
                            .fontWeight(.light)
                            .foregroundColor(.black.opacity(0.8))
                            .font(.system(size: 13))
                    }
                    Text(request.requestName)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .font(.system(size: 13))
                        .padding(.leading, 8)
                        
                    HStack(spacing: .zero){
                        Image(systemName: "timer")
                            .resizable()
                            .frame(width:15, height: 15)
                            .foregroundColor(.customBlue)
                            .padding(.leading, 8)
                        Text("時間")
                            .fontWeight(.regular)
                            .font(.system(size: 12))
                            .foregroundColor(.black.opacity(0.8))
                            .padding(.leading, 5)
                        Spacer()
                        Text(request.period)
                            .fontWeight(.regular)
                            .font(.system(size: 12))
                            .foregroundColor(.black.opacity(0.8))
                            .padding(.trailing, 8)
                    }
                    HStack(spacing: .zero){
                        Image(systemName: "rectangle.and.pencil.and.ellipsis.rtl")
                            .resizable()
                            .frame(width:15, height: 15)
                            .foregroundColor(.customRed2)
                            .padding(.leading, 8)
                            
                        Text("タグ")
                            .fontWeight(.regular)
                            .font(.system(size: 12))
                            .foregroundColor(.black.opacity(0.8))
                            .padding(.leading, 5)
                        Spacer()
                        Text(request.bigCategory)
                            .fontWeight(.regular)
                            .padding(.all, 4)
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .background(Color.customRed2)
                            .cornerRadius(10)
                            .padding(.trailing, 8)
                        
                    }
                    Spacer()
                    Text("12/18作成")
                        .fontWeight(.light)
                        .foregroundColor(.customGray)
                        .font(.system(size: 13))
                        .padding(.trailing, 8)
                        .padding(.bottom, 8)
                        .frame(maxWidth: (UIScreen.main.bounds.width/2)-40, alignment: .trailing)
                }
                .frame(width: ((UIScreen.main.bounds.width/2)-40))
            }
        }
    }
}
