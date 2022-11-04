//
//  ProfileHeaderView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/20.
//

import SwiftUI

struct HeaderView: View {
    let username: String
    var body: some View {
        
        VStack{
            HStack{
                Image("rootImage").resizable().background(Color.orange).frame(width: 100, height: 100).cornerRadius(100)
                VStack(alignment: .leading){
                    Text(username).bold().font(.system(size: 24)).padding(.trailing,100)
                    NavigationLink {
                        ConnectAccountView()
                    } label: {
                        Text("ひとこまを販売する").bold().foregroundColor(Color.white).frame(width: 200,height: 30).background(Color.green).cornerRadius(15)
                    }
                }
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(username: "長崎りお")
    }
}
