//
//  OneRequestView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct OneRequestView: View {
    @State var requestImage: String
    @State var requestTitle: String
    var body: some View {
        VStack{
            ZStack(alignment: .topTrailing){
                WebImage(url: URL(string: requestImage)).resizable().frame(width: 80, height: 80).clipShape(Circle()).shadow(radius: 10, x:10, y:10)
                Image(systemName: "questionmark.circle.fill").resizable().frame(width: 30, height: 30).foregroundColor(.black).background(.white).cornerRadius(60).overlay(Circle().stroke(.white, lineWidth: 3))
            }
            Text(requestTitle).foregroundColor(.black).frame(width: 110).font(.system(size: 13))
        }
    }
}

struct OneRequestView_Previews: PreviewProvider {
    static var previews: some View {
        OneRequestView(requestImage: "https://firebasestorage.googleapis.com:443/v0/b/marketsns.appspot.com/o/UserProfile%2F604FD023-3538-4D40-8EBE-B3621C825B02?alt=media&token=5dc5350f-c120-4b7c-9129-430aa2a2ebc1", requestTitle: "教えて")
    }
}
