//
//  PurchaseView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/10.
//

import SwiftUI

struct PurchaseView: View {
    let lessonId: String
    let amount: Int
    let lessonImageURLString: String
    let lessonName: String
    let mentorIconImageURLString: String
    let mentorName: String
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .zero){
                HStack{
                    Text("お支払い金額").bold().padding(.leading, 16)
                    Spacer()
                    Text("\(amount + (amount/10))円").bold().padding(.trailing, 16)
                }.frame(height: 50).background(.ultraThinMaterial)
                Divider()
                HStack{
                    Text("購入内容").padding(.leading, 16)
                    Spacer()
                    Text("\(amount)円").bold().padding(.trailing, 16)
                }.padding(.top, 10)
                LessonSummaryView(lessonImageURLString: lessonImageURLString, lessonName: lessonName, mentorIconImageURLString: mentorIconImageURLString, mentorName: mentorName).padding(.top, 10)
                Divider().padding(.top, 10)
                HStack{
                    Text("サービス手数料").padding(.leading, 16)
                    Spacer()
                    Text("\(amount/10)円").bold().padding(.trailing, 16)
                }.padding(.top, 10)
                Divider().padding(.top, 10)
                CheckoutView(model: MyBackendModel(), amount: amount, lessonId: lessonId).padding(.leading, 20).padding(.top, 10)
            }
        }.navigationTitle("購入手続き")
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView(lessonId: "", amount: 2000, lessonImageURLString: "", lessonName: "", mentorIconImageURLString: "", mentorName: "")
    }
}
