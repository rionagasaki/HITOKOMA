//
//  makeLessonView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/03.
//

import SwiftUI
import FirebaseFirestore
import PKHUD

struct MakeLessonView: View {

    @StateObject var viewModel = MakeLessonViewModel()
    @State var showingImagePicker = false
    @State var period: String = ""
    @State var selectedDate = Date()
    
    var hourCategories = ["30分","60分","90分","120分","150分","180分"]
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading){
                    Text("Step. 1").bold().font(.system(size: 25)).foregroundColor(.init(uiColor: .darkGray).opacity(0.8)).padding(.leading,10)
                    Text("レッスンの基本情報を記述してください。").bold().padding(.leading,10)
                    VStack{
                        if viewModel.lessonImage == nil {
                            Button {
                                showingImagePicker = true
                            } label: {
                                ZStack{
                                    Image("noImage").resizable().frame(width: 100, height:100).clipShape(Circle())
                                }.frame(width: UIScreen.main.bounds.width, height:300).background(.white.opacity(0.1)).background(.ultraThinMaterial).overlay(RoundedRectangle(cornerRadius: 0).stroke(.gray.opacity(0.6), lineWidth: 0.5)).shadow(radius: 1)
                            }
                        }else{
                            Button {
                                showingImagePicker = true
                            } label: {
                                Image(uiImage: viewModel.lessonImage!).resizable().frame(width: UIScreen.main.bounds.width, height:300 ).background(.white.opacity(0.1)).background(.ultraThinMaterial).overlay(RoundedRectangle(cornerRadius: 0).stroke(.gray.opacity(0.6), lineWidth: 0.5)).shadow(radius: 1)
                            }
                        }
                    }.frame(width: UIScreen.main.bounds.width ,height: 300)
                    HStack {
                        HStack{
                            Image(systemName: "book.closed.fill").resizable().foregroundColor(.orange).frame(width:20, height:20).padding(.leading,16)
                            Text("カテゴリー")
                        }
                        Spacer()
                        Menu {
                            selectCategory(bigCategory: "英語", detailCategories: englishCategories)
                            selectCategory(bigCategory: "IT", detailCategories: computerCategories)
                            selectCategory(bigCategory: "法律", detailCategories: lawCategories)
                            selectCategory(bigCategory: "ファイナンス", detailCategories: financeCategories)
                            selectCategory(bigCategory: "投資", detailCategories: investmentCategories)
                        } label: {
                            VStack(spacing: 5){
                                HStack{
                                    Text(viewModel.lessonCategory != "" ? viewModel.lessonCategory :"カテゴリー")
                                        .foregroundColor(viewModel.lessonCategory != "" ? .black: .gray)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(Color.customBlue)
                                        .font(Font.system(size: 20, weight: .bold))
                                }
                                Rectangle()
                                    .fill(Color.customBlue)
                                    .frame(height: 2)
                            }.padding(.vertical,16)
                        }.padding(.trailing,16).frame(width:200)
                    }
                    TextField("レッスンタイトル", text: $viewModel.lessonName).padding().frame(width: UIScreen.main.bounds.width-30, height:50).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2)).padding(.bottom, 10).padding(.leading,10)
                    Text("Step. 2").bold().font(.system(size: 25)).foregroundColor(.init(uiColor: .darkGray).opacity(0.8)).padding(.leading,10).padding(.top, 16)
                    Text("レッスンの値段、時間を教えてください。").bold().padding(.leading,10)
                    VStack{
                        HStack{
                            Image(systemName: "checkmark.square.fill").resizable().foregroundColor(.green).frame(width:20, height:20)
                            Text("予算")
                            Spacer()
                            TextField("予算", value: $viewModel.budget, formatter: NumberFormatter())
                                .keyboardType(.numberPad).padding(.all, 7).frame(width:200).overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2))
                            Text("円")
                        }.padding(.horizontal,10)
                    }
                    HStack{
                        Image(systemName: "timer").resizable().foregroundColor(.orange).frame(width:20, height:20)
                        Text("時間")
                        Spacer()
                        Menu {
                            ForEach(self.hourCategories, id: \.self) { hour in
                                Button {
                                    period = hour
                                } label: {
                                    Text(hour)
                                }
                            }
                        } label: {
                            VStack(spacing: 5){
                                HStack{
                                    Text(period != "" ? period :"時間")
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(Color.customBlue)
                                        .font(Font.system(size: 20, weight: .bold))
                                }
                                Rectangle()
                                    .fill(Color.customBlue)
                                    .frame(height: 2)
                            }.padding(.vertical,16)
                        }.frame(width:200)
                    }.padding(.leading, 10).padding(.trailing,20)
                }.frame(width: UIScreen.main.bounds.width).padding(.all,7).background(.white.opacity(0.3)).background(.ultraThinMaterial).padding(.top,10)
                VStack(alignment: .leading){
                    Text("Step. 3").bold().font(.system(size: 25)).foregroundColor(.init(uiColor: .darkGray).opacity(0.8)).padding(.top,16)
                    Text("レッスンの詳細を記述してください。").bold()
                    TextEditor(text: $viewModel.lessonContent).padding().frame(width: UIScreen.main.bounds.width-30, height:500).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2)).padding(.top, 10)
                }
                Spacer()
            }
        }.navigationTitle("ひとこまを作成する").navigationBarTitleDisplayMode(.inline).sheet(isPresented: $showingImagePicker) {
            ImagePicker(sourceType: .photoLibrary ,selectedImage: $viewModel.lessonImage)
        }
        Button {
            
        } label: {
            Text("作成する").foregroundColor(.white).font(.system(size: 17)).bold().frame(width: UIScreen.main.bounds.width-40, height: 50).background(Color.customBlue).cornerRadius(10)
        }.frame(width: UIScreen.main.bounds.width, height: 70).background(.ultraThinMaterial)
    }
    
    func selectCategory(bigCategory: String, detailCategories:[String]) -> some View {
        Menu {
            ForEach(detailCategories, id: \.self) { category in
                Button {
                    viewModel.lessonCategory = category
                    viewModel.bigCategory = bigCategory
                } label: {
                    Text(category)
                }
            }
        } label: {
            Text(bigCategory)
        }
    }
}


struct MakeLessonView_Previews: PreviewProvider {
    static var previews: some View {
        MakeLessonView()
    }
}
