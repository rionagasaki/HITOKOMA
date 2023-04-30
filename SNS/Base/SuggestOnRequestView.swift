//
//  AdjustmentView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/07.
//

import SwiftUI

struct SuggestOnRequestView: View {
    @StateObject var viewModel:SuggestOnRequestViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack{
                        RequestInfoView(request: viewModel.requestData)
                        TextField("", text: $viewModel.budgeText, prompt: Text("提示金額"))
                            .padding()
                            .frame(width: UIScreen.main.bounds.width-30, height:50)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2))
                            .padding(.bottom, 8)
                        
                        ZStack(alignment: .topLeading){
                            TextEditor(text: $viewModel.appealText)
                                .padding()
                                .frame(width: UIScreen.main.bounds.width-30, height:150)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2))
                                .padding(.bottom, 8)
                            Text("提案内容")
                                .foregroundColor(.customGray).opacity(0.6)
                                .padding(.top, 16)
                                .padding(.leading, 16)
                        }
                    }
                }
                NavigationLink {
                    CheckSuggestionView()
                } label: {
                    Text("提案する")
                        .bold()
                        
                }
            }
        }
    }
}
