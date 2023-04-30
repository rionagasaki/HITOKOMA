//
//  SuggestionView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/24.
//

import SwiftUI

struct SuggestionView: View {
    let classImage:String
    let classTitle:String
    let classDescription:String
    
    var body: some View {
        HStack(alignment: .top){
            Image(classImage)
                .resizable()
                .frame(width: 80, height: 80)
                .cornerRadius(5)
                .padding(.leading,16)
                .padding(.vertical,5)
            VStack(alignment: .leading ,spacing:7){
                Text(classTitle)
                    .bold()
                Text(classDescription)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

struct SuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionView(classImage: "rootImage", classTitle: "aaaaaa", classDescription: "aaaaaafekfjjkjkefjkf")
    }
}
