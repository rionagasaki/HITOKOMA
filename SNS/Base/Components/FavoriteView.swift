//
//  FavoriteView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/21.
//

import SwiftUI

struct FavoriteView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                VStack{
                    Image("").resizable().frame(width: 80, height: 80).cornerRadius(20).overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 0.5))
                    Text("英語").foregroundColor(Color(uiColor: .darkGray)).font(.system(size: 13))
                }
                VStack{
                    Image("study").resizable().frame(width: 80, height: 80).cornerRadius(20).overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 0.5))
                    Text("ネットワーク").foregroundColor(Color(uiColor: .darkGray)).font(.system(size: 13))
                }
                VStack{
                    Image("suit").resizable().frame(width: 80, height: 80).cornerRadius(20).overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 0.5))
                    Text("数学").foregroundColor(Color(uiColor: .darkGray)).font(.system(size: 13))
                }
                VStack{
                    Image("computer").resizable().frame(width: 80, height: 80).cornerRadius(20).overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 0.5))
                    Text("化学").foregroundColor(Color(uiColor: .darkGray)).font(.system(size: 13))
                }
                VStack{
                    Image("ramen").resizable().frame(width: 80, height: 80).cornerRadius(20).overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 0.5))
                    Text("物理").foregroundColor(Color(uiColor: .darkGray)).font(.system(size: 13))
                }
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
