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
  
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading){
                    Group {
                        Text("Step. 1")
                            .bold()
                            .font(.system(size: 25))
                            .foregroundColor(.init(uiColor: .darkGray).opacity(0.8))
                        Text("レッスンの基本情報を記述してください。")
                            .bold()
                    }
                    .padding(.leading, 16)
                    
                    MakeLessonFirstSectionView(viewModel: viewModel)
                    
                    Group {
                        Text("Step. 2")
                            .bold()
                            .font(.system(size: 25))
                            .foregroundColor(.init(uiColor: .darkGray).opacity(0.8))
                        Text("レッスンの値段、時間を教えてください。")
                            .bold()
                        
                    }
                    .padding(.leading, 16)
                    MakeLessonSecondSectionView(viewModel: viewModel)
                
                    Button {
                        viewModel.makeLesson()
                    } label: {
                        Text("作成する")
                            .foregroundColor(.white)
                            .font(.system(size: 17))
                            .bold()
                            .frame(width: UIScreen.main.bounds.width-40, height: 50)
                            .background(Color.customBlue)
                            .cornerRadius(10)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }.navigationTitle("レッスン内容入力")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $viewModel.showingImagePicker) {
                    ImagePicker(sourceType: .photoLibrary ,selectedImage: $viewModel.lessonImage)
                }
            
        }
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

struct MakeLessonFirstSectionView: View {
    
    @StateObject var viewModel: MakeLessonViewModel
    
    var body: some View {
        VStack {
            Group {
                CustomDividerWidthText(
                    text: "カテゴリー選択",
                    requiered: true)
                .padding(.vertical,8)
                Menu {
                    selectCategory(
                        bigCategory: "英語",
                        detailCategories: englishCategories
                    )
                    selectCategory(
                        bigCategory: "IT",
                        detailCategories: computerCategories
                    )
                    selectCategory(
                        bigCategory: "法律",
                        detailCategories: lawCategories
                    )
                    selectCategory(
                        bigCategory: "ファイナンス",
                        detailCategories: financeCategories
                    )
                    selectCategory(
                        bigCategory: "投資",
                        detailCategories: investmentCategories
                    )
                } label: {
                    Text(viewModel.lessonCategory != "" ? viewModel.lessonCategory :"カテゴリー")
                        .foregroundColor(viewModel.lessonCategory == "" ? .gray: .black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.top,8)
                        .padding(.bottom, 16)
                    
                }
            }
            
            Group {
                CustomDividerWidthText(
                    text: "タイトル",
                    requiered: true)
                TextField("タイトル", text: $viewModel.lessonName)
                    .frame(width: UIScreen.main.bounds.width-32, height:50)
                    .padding(.vertical, 8)
            }
            Group {
                CustomDividerWidthText(
                    text: "イメージ",
                    requiered: true)
                Button {
                    viewModel.showingImagePicker = true
                } label: {
                    if let lessonImage = viewModel.lessonImage {
                        Image(uiImage: lessonImage)
                            .resizable()
                            .frame(width: 113, height: 70)
                            .padding(.vertical, 16)
                    } else {
                        Rectangle()
                            .fill()
                            .frame(width: 113, height: 70)
                            .foregroundColor(.customLightGray)
                            .padding(.vertical, 16)
                    }
                }
            }
            
            Group {
                CustomDividerWidthText(
                    text: "詳細",
                    requiered: true)
                
                ZStack(alignment: .topLeading){
                    TextEditor(text: $viewModel.lessonContent)
                        .padding(.leading, 16)
                        .padding(.top, 16)
                        .frame(width: UIScreen.main.bounds.width, height:150)
                        .cornerRadius(10)
                    if viewModel.lessonContent == "" {
                        Text("詳細")
                            .foregroundColor(.customGray)
                            .opacity(0.6)
                            .padding(.top, 20)
                            .padding(.leading, 20)
                    }
                }
                CustomDivider()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                VStack {
                    Image(systemName: "square.and.pencil")
                    Text("下書き")
                        .fontWeight(.light)
                        .font(.system(size: 12))
                }
            }
        }
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

struct MakeLessonSecondSectionView: View {
    
    @StateObject var viewModel: MakeLessonViewModel

    var body: some View {
        VStack{
            Group {
                CustomDividerWidthText(text: "タイプ", requiered: true)
                    .padding(.vertical,8)
                Toggle(isOn: $viewModel.isFree) {
                    Text(viewModel.isFree ? "無料":"有料")
                        .fontWeight(.light)
                        .font(.system(size:15))
                        
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                
                CustomDividerWidthText(text: "料金", requiered: !viewModel.isFree)
                    .padding(.vertical,8)
                TextField("料金", value: $viewModel.budget, format: .number)
                    .frame(width: UIScreen.main.bounds.width-32)
                    .disabled(viewModel.isFree)
                    .padding(.top,8)
                    .padding(.bottom, 16)
            }
            CustomDividerWidthText(text: "日時", requiered: true)
            
            DatePicker("", selection: $viewModel.lessonDate)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.trailing, 16)
                .padding(.vertical, 16)
            CustomDividerWidthText(text: "時間", requiered: true)
            Menu {
                ForEach(viewModel.hourCategories, id: \.self) { hour in
                    Button {
                        viewModel.lessonPeriod = hour
                    } label: {
                        Text(hour)
                            .fontWeight(.medium)
                            .font(.system(size: 15))
                    }
                }
            } label: {
                Text(viewModel.lessonPeriod == "" ? "時間": viewModel.lessonPeriod)
                    .foregroundColor(viewModel.lessonCategory == "" ? .gray: .black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                    .padding(.vertical, 16)
            }
            CustomDivider()
        }
    }
}
