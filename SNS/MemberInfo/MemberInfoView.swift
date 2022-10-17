//
//  MemberInfoView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/15.
//

import SwiftUI

struct MemberInfoView: View {
    var body: some View {
        NavigationView {
            VStack{
                
                Form {
                    Section {
                        GeometryReader { geometry in
                            Image("home").resizable().scaledToFill().mask {
                                Circle().frame(width: 100, height: 100)
                            }.frame(width: 100)
                        }.frame(width: 0, height: 0)
                    }
                    Section {
                        Text("aaa")
                    } header: {
                        HStack{
                            Text("お名前")
                        }
                    }

                }
            }.navigationTitle("会員情報")
        }
    }
}

struct MemberInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MemberInfoView()
    }
}
