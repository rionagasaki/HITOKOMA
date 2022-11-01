//
//  DashBoardView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/02.
//

import SwiftUI

struct DashBoardView: View {
    let model = DashBoardCall()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).onAppear {
            model.callBackend()
        }
    }
}

struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView()
    }
}


