//
//  SearchResultClassView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/06.
//

import SwiftUI

struct SearchResultClassView: View {
    var body: some View {
        VStack(alignment: .leading){
            Image("rootImage").resizable().frame(width:(UIScreen.main.bounds.width/2)-20, height:(UIScreen.main.bounds.width/2)-40)
            Text("英語TOEIC990点です。教えてます。").frame(width: (UIScreen.main.bounds.width/2))
            Text("長崎りお").foregroundColor(.init(uiColor: .lightGray)).font(.system(size: 13))
        }
    }
}

struct SearchResultClassView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultClassView()
    }
}
