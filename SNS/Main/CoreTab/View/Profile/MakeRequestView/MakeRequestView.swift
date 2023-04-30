//
//  MakeRequestView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/07.
//

import SwiftUI
import PKHUD


struct MakeRequestView: View {
    @StateObject private var viewModel = MakeRequestViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text("Step. 1")
                            .bold()
                            .font(.system(size: 25))
                            .foregroundColor(.init(uiColor: .darkGray).opacity(0.8))
                        Text("どんなことを教えて欲しいですか？")
                            .bold()
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
                            VStack(spacing: 5){
                                HStack{
                                    Text(viewModel.selectedCategory == "" ? "カテゴリー": viewModel.selectedCategory)
                                        .foregroundColor(viewModel.selectedCategory == "" ? .gray: .black)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(Color.customBlue)
                                        .font(Font.system(size: 20, weight: .bold))
                                }
                                Rectangle()
                                    .fill(Color.customBlue)
                                    .frame(height: 2)
                            }
                            .padding(.vertical,16)
                            .padding(.trailing,20)
                        }
                    }
                    .padding(.leading,20)
                    
                    VStack(alignment: .leading){
                        Text("Step. 2")
                            .bold()
                            .font(.system(size: 25))
                            .foregroundColor(.init(uiColor: .darkGray).opacity(0.8))
                        Text("教わりたいことの詳細を教えてください。\n(画像は任意です。)").bold()
                        Button {
                            viewModel.showImageModal = true
                        } label: {
                            if let requestImage = viewModel.requestImage  {
                                Image(uiImage: requestImage)
                                    .resizable()
                                    .frame(height: 200)
                                    .scaledToFill()
                            } else {
                                Image("noImage")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .clipShape(Circle())
                                    .frame(width: UIScreen.main.bounds.width-40, height: 200)
                                    .background(.gray.opacity(0.3))
                                    .background(.ultraThinMaterial)
                            }
                        }
                        TextField("タイトル", text: $viewModel.requestTitle)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width-16, height:50)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2))
                            .padding(.bottom, 8)
                        
                        ZStack(alignment: .topLeading){
                            TextEditor(text: $viewModel.requestContents)
                                .padding()
                                .frame(width: UIScreen.main.bounds.width-16, height:150)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2))
                                .padding(.bottom, 8)
                            Text("詳細")
                                .foregroundColor(.customGray)
                                .opacity(0.6)
                                .padding(.top, 16)
                                .padding(.leading, 8)
                        }
                    }
                    .padding(.leading,20)
                    .padding(.top, 25)
                    
                    VStack(alignment: .leading){
                        Text("Step. 3")
                            .bold()
                            .font(.system(size: 25))
                            .foregroundColor(.init(uiColor: .darkGray).opacity(0.8))
                        Text("最後に条件を教えてください。")
                            .bold()
                        VStack{
                            HStack{
                                Image(systemName: "checkmark.square.fill")
                                    .resizable()
                                    .foregroundColor(.green)
                                    .frame(width:20, height:20)
                                Text("予算")
                                Spacer()
                                TextField("予算",
                                          value: $viewModel.numberPicker,
                                          formatter: NumberFormatter()
                                )
                                    .keyboardType(.numberPad)
                                    .padding(.all, 7)
                                    .frame(width:200)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                                Text("円")
                            }
                            .padding(.leading, 5)
                            HStack{
                                Image(systemName: "calendar.badge.clock.rtl")
                                    .resizable()
                                    .foregroundColor(.blue)
                                    .frame(width:20, height:20)
                                Text("日時")
                                Spacer()
                                DatePicker("", selection: Binding($viewModel.selectedDate)!)
                                Text("~ ")
                                    .padding(.trailing,3)
                            }
                            .padding(.leading, 5)
                            HStack{
                                Image(systemName: "timer")
                                    .resizable()
                                    .foregroundColor(.orange)
                                    .frame(width:20, height:20)
                                Text("時間")
                                Spacer()
                                Menu {
                                    ForEach(viewModel.hourCategories, id: \.self) { hour in
                                        Button {
                                            print("aaa")
                                            viewModel.period = hour
                                        } label: {
                                            Text(hour)
                                        }
                                    }
                                } label: {
                                    VStack(spacing: 5){
                                        HStack{
                                            Text(viewModel.period != "" ? viewModel.period :"時間")
                                                .foregroundColor(
                                                    viewModel.value.isEmpty ? .gray : .black
                                                )
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(Color.blue)
                                                .font(Font.system(size: 20, weight: .bold))
                                        }
                                        Rectangle()
                                            .fill(Color.customBlue)
                                            .frame(height: 2)
                                    }.padding(.vertical,16)
                                }.frame(width:200)
                                
                            }
                            .padding(.leading, 5)
                        }
                        .frame(width: UIScreen.main.bounds.width-40)
                        .padding(.all,7)
                        .background(.white.opacity(0.3))
                        .background(.ultraThinMaterial)
                        .padding(.top,10)
                    }
                    .padding(.leading,13).padding(.top, 25)
                }
                VStack{
                    if viewModel.shouldValidate {
                        Text("未入力の項目があります。").foregroundColor(.red)
                    }
                }
                .padding(.top, 16)
            }
            Button {
                if viewModel.requestTitle != ""
                    && viewModel.requestContents != ""
                    && viewModel.requestImage != nil
                    && viewModel.selectedDate != nil
                    && viewModel.period != ""
                    && viewModel.selectedCategory != "" {
                    
                    viewModel.shouldValidate = false
                    
                    RegisterStorage().refisterImageToStorage(
                        folderName: "RequestImage",
                        profileImage: viewModel.requestImage!
                    ){ imageURL in
                        let requestImageURLString = imageURL.absoluteString
                        SetToFirestore()
                            .registerRequestInfoFirestore(
                                requestName: viewModel.requestTitle,
                                requestContents: viewModel.requestContents,
                                bigCategory: viewModel.bigCategory,
                                selectedCategory: viewModel.selectedCategory,
                                requestImageURL: requestImageURLString,
                                budget: viewModel.numberPicker,
                                date: viewModel.selectedDate!,
                                period: viewModel.period
                            ) {
                            HUD.flash(.success, delay: 1.0)
                        }
                    }
                }else {
                    viewModel.shouldValidate = true
                }
            } label: {
                Text("確認画面へ")
                    .foregroundColor(.white)
                    .font(.system(size: 17))
                    .bold()
                    .frame(width: UIScreen.main.bounds.width-40, height: 50)
                    .background(Color.customBlue)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("依頼を作成する")
        .sheet(isPresented: $viewModel.showImageModal) {
            ImagePicker(
                sourceType: .photoLibrary,
                selectedImage: $viewModel.requestImage
            )
        }
    }
    
    func selectCategory(bigCategory: String, detailCategories:[String]) -> some View {
        Menu {
            ForEach(detailCategories, id: \.self) { category in
                Button {
                    viewModel.selectedCategory = category
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

struct MakeRequestView_Previews: PreviewProvider {
    static var previews: some View {
        MakeRequestView()
    }
}


var categories = ["英語", "IT", "法律", "ファイナンス", "投資"]
var englishCategories = ["TOEIC", "TOEFL", "英検", "その他"]
var computerCategories = ["基本/応用情報", "プログラミング", "E資格"]
var lawCategories = ["宅建"]
var financeCategories = ["会計士","簿記"]
var investmentCategories = ["株式取引", "為替取引", "資産運用"]
