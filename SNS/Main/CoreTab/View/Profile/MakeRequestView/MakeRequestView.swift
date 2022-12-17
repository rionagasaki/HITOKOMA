//
//  MakeRequestView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/07.
//

import SwiftUI
import PKHUD

struct MakeRequestView: View {
    @State var value = ""
    @State var requestTitle: String
    @State var requestContents: String
    @State var showImageModal:Bool = false
    @State var requestImageURL:String?
    @State var selectedDate: Date?
    @State var numberPicker:Int = 1500
    @State var period: String
    @State var shouldValidate: Bool = false
    @State var requestImage: UIImage?
    @State var bigCategory: String
    @State var selectedCategory: String
    var dropDownList = ["PSO", "PFA", "AIR", "HOT"]
    var hourCategories = ["30分","60分","90分","120分","150分","180分"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text("Step. 1").bold().font(.system(size: 25)).foregroundColor(.init(uiColor: .darkGray).opacity(0.8))
                    Text("どんなことを教えて欲しいですか？").bold()
                    Menu {
                        selectCategory(bigCategory: "英語", detailCategories: englishCategories)
                        selectCategory(bigCategory: "IT", detailCategories: computerCategories)
                        selectCategory(bigCategory: "法律", detailCategories: lawCategories)
                        selectCategory(bigCategory: "ファイナンス", detailCategories: financeCategories)
                        selectCategory(bigCategory: "投資", detailCategories: investmentCategories)
                    } label: {
                        VStack(spacing: 5){
                            HStack{
                                Text(self.selectedCategory == "" ? "カテゴリー": self.selectedCategory)
                                    .foregroundColor(self.selectedCategory == "" ? .gray: .black)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color.customBlue)
                                    .font(Font.system(size: 20, weight: .bold))
                            }
                            Rectangle()
                                .fill(Color.customBlue)
                                .frame(height: 2)
                        }.padding(.vertical,16).padding(.trailing,20)
                    }
                }.padding(.leading,20)
                
                VStack(alignment: .leading){
                    Text("Step. 2").bold().font(.system(size: 25)).foregroundColor(.init(uiColor: .darkGray).opacity(0.8))
                    Text("教わりたいことの詳細を教えてください。\n(画像は任意です。)").bold()
                    Button {
                        self.showImageModal = true
                    } label: {
                        ZStack{
                            Image("noImage").resizable().frame(width: 70, height: 70).clipShape(Circle())
                        }.frame(width: UIScreen.main.bounds.width-40, height: 200).background(.gray.opacity(0.3)).background(.ultraThinMaterial)
                    }
                    Text("タイトル")
                    TextField("タイトル", text: $requestTitle).padding(.all, 8).frame(width: UIScreen.main.bounds.width-40).overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 1))
                    Text("詳細")
                    TextEditor(text: $requestContents).frame(width: UIScreen.main.bounds.width-40, height: 200).overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 1))

                }.padding(.leading,20).padding(.top, 25)
                VStack(alignment: .leading){
                    Text("Step. 3").bold().font(.system(size: 25)).foregroundColor(.init(uiColor: .darkGray).opacity(0.8))
                    Text("最後に条件を教えてください。").bold()
                    VStack{
                        HStack{
                            Image(systemName: "checkmark.square.fill").resizable().foregroundColor(.green).frame(width:20, height:20)
                            Text("予算")
                            Spacer()
                            TextField("予算", value: $numberPicker, formatter: NumberFormatter())
                                .keyboardType(.numberPad).padding(.all, 7).frame(width:200).overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                            Text("円")
                        }.padding(.leading, 5)
                        HStack{
                            Image(systemName: "calendar.badge.clock.rtl").resizable().foregroundColor(.blue).frame(width:20, height:20)
                            Text("日時")
                            Spacer()
                            DatePicker("", selection: Binding($selectedDate)!)
                            Text("~ ").padding(.trailing,3)
                        }.padding(.leading, 5)
                        HStack{
                            Image(systemName: "timer").resizable().foregroundColor(.orange).frame(width:20, height:20)
                            Text("時間")
                            Spacer()
                            Menu {
                                ForEach(self.hourCategories, id: \.self) { hour in
                                    Button {
                                        print("aaa")
                                        self.period = hour
                                    } label: {
                                        Text(hour)
                                    }
                                }
                            } label: {
                                VStack(spacing: 5){
                                    HStack{
                                        Text(self.period != "" ? self.period :"時間")
                                            .foregroundColor(value.isEmpty ? .gray : .black)
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

                        }.padding(.leading, 5)
                    }.frame(width: UIScreen.main.bounds.width-40).padding(.all,7).background(.white.opacity(0.3)).background(.ultraThinMaterial).padding(.top,10)
                }.padding(.leading,13).padding(.top, 25)
            }
            VStack{
                if shouldValidate {
                    Text("未入力の項目があります。").foregroundColor(.red)
                }
                Button {
                    if requestTitle != "" && requestContents != "" && selectedDate != nil && period != "" && selectedCategory != ""{
                        self.shouldValidate = false
                        SetToFirestore().registerRequestInfoFirestore(requestName: requestTitle, requestContents: requestContents, bigCategory: bigCategory, selectedCategory: selectedCategory, requestImageURL: requestImageURL, budget: numberPicker, date: selectedDate!, period: period) {
                            HUD.flash(.success, delay: 1.0)
                        }
                    }else{
                        self.shouldValidate = true
                    }
                } label: {
                    Text("リクエストする").foregroundColor(.white).font(.system(size: 17)).bold().frame(width: UIScreen.main.bounds.width-40, height: 50).background(Color.customBlue).cornerRadius(10)
                }
            }.padding(.top, 16)
        }.navigationTitle("依頼を作成する").sheet(isPresented: $showImageModal) {
            ImagePicker(sourceType: .photoLibrary,selectedImage: $requestImage)
        }
    }
    
    func selectCategory(bigCategory: String, detailCategories:[String]) -> some View {
        Menu {
            ForEach(detailCategories, id: \.self) { category in
                Button {
                    self.selectedCategory = category
                    self.bigCategory = bigCategory
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
        MakeRequestView(requestTitle: "", requestContents: "", selectedDate: Date(), numberPicker: 0, period: "", bigCategory: "", selectedCategory: "")
    }
}


var categories = ["英語", "IT", "法律", "ファイナンス", "投資"]
var englishCategories = ["TOEIC", "TOEFL", "英検", "その他"]
var computerCategories = ["基本/応用情報", "プログラミング", "E資格"]
var lawCategories = ["宅建"]
var financeCategories = ["会計士","簿記"]
var investmentCategories = ["株式取引", "為替取引", "資産運用"]
