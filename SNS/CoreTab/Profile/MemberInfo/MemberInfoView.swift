//
//  MemberInfoView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/15.
//

import SwiftUI
import FirebaseFirestore

struct MemberInfoView: View {
    var body: some View {
        NavigationView {
            VStack{
                Form {
                    Section {
                        
                    } header:{
                        
                    }
                    Section {
                        VStack{
                            Text("長崎りお")
                        }
                        Text("naga_ri@icloud.com")
                    } header: {
                        HStack{
                            Text("基本情報")
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
