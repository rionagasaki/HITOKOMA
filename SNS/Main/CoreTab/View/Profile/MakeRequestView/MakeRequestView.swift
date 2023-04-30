//
//  MakeRequestView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/07.
//

import SwiftUI
import PKHUD

var categories = ["英語", "IT", "法律", "ファイナンス", "投資"]
var englishCategories = ["TOEIC", "TOEFL", "英検", "その他"]
var computerCategories = ["基本/応用情報", "プログラミング", "E資格"]
var lawCategories = ["宅建"]
var financeCategories = ["会計士","簿記"]
var investmentCategories = ["株式取引", "為替取引", "資産運用"]

struct MakeRequestView: View {
    @StateObject private var viewModel = MakeRequestViewModel()
    @State var index = 0
    var body: some View {
        VStack {
            ScrollViewReader { scroll in
                ScrollView {
                    VStack(alignment: .leading){
                        VStack(alignment: .leading){
                            Group {
                                Text("Step. 1")
                                    .bold()
                                    .font(.system(size: 25))
                                    .foregroundColor(.init(uiColor: .darkGray).opacity(0.8))
                                Text("どんなことを教えて欲しいですか？")
                                    .font(.system(size: 16))
                                    .bold()
                            }
                            .padding(.leading, 16)
                            MakeRequestFirstSectionView(viewModel: viewModel)
                            
                            Group {
                                Text("Step. 2")
                                    .bold()
                                    .font(.system(size: 25))
                                    .foregroundColor(.init(uiColor: .darkGray).opacity(0.8))
                                Text("参考画像があれば、選択してください。")
                                    .font(.system(size: 16))
                                    .bold()
                            }
                            .padding(.leading, 16)
                            MakeRequestSecondSectionView(viewModel: viewModel)
                            
                            Group {
                                Text("Step. 3")
                                    .bold()
                                    .font(.system(size: 25))
                                    .foregroundColor(.init(uiColor: .darkGray).opacity(0.8))
                                Text("最後に条件を教えてください。")
                                    .font(.system(size: 16))
                                    .bold()
                            }
                            .padding(.leading, 16)
                            MakeRequestThirdSectionView(viewModel: viewModel)
                        }
                        
                        VStack{
                            if viewModel.shouldValidate {
                                Text("未入力の項目があります。")
                                    .fontWeight(.medium)
                                    .font(.system(size: 15))
                                    .foregroundColor(.red)
                            }
                        }
                        .id(1)
                        .padding(.top, 16)
                    }
                    
                    Button {
                        if viewModel.requestTitle != ""
                            && viewModel.requestContents != ""
                            && viewModel.requestImage != []
                            && viewModel.selectedDate != nil
                            && viewModel.period != ""
                            && viewModel.selectedCategory != "" {
                            
                            viewModel.shouldValidate = false
                            guard let image = viewModel.requestImage[0] else { return }
                            RegisterStorage().refisterImageToStorage(
                                folderName: "RequestImage",
                                profileImage: image
                            ){ imageURL in
                                let requestImageURLString = imageURL.absoluteString
                                SetToFirestore()
                                    .registerRequestInfoFirestore(
                                        requestName: viewModel.requestTitle,
                                        requestContents: viewModel.requestContents,
                                        bigCategory: viewModel.bigCategory,
                                        selectedCategory: viewModel.selectedCategory,
                                        requestImageURL: requestImageURLString,
                                        budget: viewModel.budget ?? 1000,
                                        date: viewModel.selectedDate!,
                                        period: viewModel.period
                                    ) {
                                        HUD.flash(.success, delay: 1.0)
                                    }
                            }
                        }else {
                            withAnimation {
                                viewModel.shouldValidate = true
                                scroll.scrollTo(1)
                            }
                        }
                    } label: {
                        Text("作成する")
                            .foregroundColor(.white)
                            .font(.system(size: 17))
                            .bold()
                            .frame(width: UIScreen.main.bounds.width-40, height: 50)
                            .background(Color.customBlue)
                            .cornerRadius(10)
                    }
                    .padding(.top, 16)
                    
                    Button {
                        
                    } label: {
                        Text("下書き保存")
                            .foregroundColor(Color.customBlue)
                            .font(.system(size: 17))
                            .bold()
                            .frame(width: UIScreen.main.bounds.width-40, height: 50)
                            .background(Color.customLightGray)
                            .cornerRadius(10)
                    }
                }
            }
            .navigationTitle("リクエストを入力")
            .sheet(isPresented: $viewModel.showImageModal) {
                ImagePicker(
                    sourceType: .photoLibrary,
                    selectedImage: $viewModel.requestImage[viewModel.selection]
                )
            }
        }
    }
}

struct MakeRequestView_Previews: PreviewProvider {
    static var previews: some View {
        MakeRequestView()
    }
}

struct MakeRequestFirstSectionView: View {
    
    @StateObject var viewModel: MakeRequestViewModel
    
    var body: some View {
        VStack {
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
                Text(viewModel.selectedCategory == "" ? "カテゴリー": viewModel.selectedCategory)
                    .foregroundColor(viewModel.selectedCategory == "" ? .gray: .black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                    .padding(.top,8)
                    .padding(.bottom, 16)
                
            }
            CustomDividerWidthText(
                text: "タイトル",
                requiered: true)
            TextField("タイトル", text: $viewModel.requestTitle)
                .frame(width: UIScreen.main.bounds.width-32, height:50)
                .padding(.vertical, 8)
            
            CustomDividerWidthText(
                text: "詳細",
                requiered: true)
            
            ZStack(alignment: .topLeading){
                TextEditor(text: $viewModel.requestContents)
                    .padding(.leading, 16)
                    .padding(.top, 16)
                    .frame(width: UIScreen.main.bounds.width, height:150)
                    .cornerRadius(10)
                if viewModel.requestContents == "" {
                    Text("詳細")
                        .foregroundColor(.customGray)
                        .opacity(0.6)
                        .padding(.top, 20)
                        .padding(.leading, 20)
                }
            }
            CustomDivider()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationLink {
                    DraftView()
                } label: {
                    VStack {
                        Image(systemName: "square.and.pencil")
                        Text("下書き")
                            .fontWeight(.light)
                            .font(.system(size: 12))
                    }
                }
            }
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

struct MakeRequestSecondSectionView: View {
    @StateObject var viewModel: MakeRequestViewModel
    var body: some View {
        VStack {
            Button {
                viewModel.showImageModal = true
            } label: {
                ScrollView {
                    HStack {
                        ForEach(viewModel.requestImage.indices, id: \.self){ index in
                            if let requestImage = viewModel.requestImage[index] {
                                Image(uiImage: requestImage)
                                    .resizable()
                                    .frame(width: 113, height: 70)
                                    .background(Color.customLightGray)
                                    .scaledToFill()
                                    .cornerRadius(10)
                                    .padding(.horizontal, 16)
                            }
                        }
                    }
                }
            }
            Button {
                viewModel.requestImage.append(UIImage())
                viewModel.selection = viewModel.requestImage.count
            } label: {
                Image(systemName: "plus.app.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.customBlue)
                
            }
            CustomDivider()
        }
    }
}

struct MakeRequestThirdSectionView: View {
    
    @StateObject var viewModel: MakeRequestViewModel
    
    var body: some View {
        VStack{
            CustomDividerWidthText(text: "予算", requiered: true)
                .padding(.vertical,8)
            TextField("予算", value: $viewModel.budget, format: .number)
                .frame(width: UIScreen.main.bounds.width-32, height:50)
                .padding(.vertical, 8)
            
            CustomDividerWidthText(text: "日時", requiered: true)
            
            DatePicker("", selection: Binding($viewModel.selectedDate)!)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.trailing, 16)
                .padding(.vertical, 16)
            CustomDividerWidthText(text: "時間", requiered: true)
            Menu {
                ForEach(viewModel.hourCategories, id: \.self) { hour in
                    Button {
                        viewModel.period = hour
                    } label: {
                        Text(hour)
                    }
                }
            } label: {
                Text(viewModel.period == "" ? "時間": viewModel.period)
                    .foregroundColor(viewModel.selectedCategory == "" ? .gray: .black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                    .padding(.vertical,16)
            }
            CustomDivider()
        }
    }
}

