//
//  FullImageView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/04.
//

import SwiftUI
import SDWebImageSwiftUI

struct FullImageView: View {
    let messageImageURLString: String
    var body: some View {
        ZStack{
            Color.black
            WebImage(url: URL(string: messageImageURLString)).resizable().scaledToFit().frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.height-100)
        }.ignoresSafeArea()
    }
}

struct FullImageView_Previews: PreviewProvider {
    static var previews: some View {
        FullImageView(messageImageURLString: "")
    }
}
