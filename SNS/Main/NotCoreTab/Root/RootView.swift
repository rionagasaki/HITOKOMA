//
//  RootView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/03.
//

import SwiftUI
import FirebaseAuth

struct RootView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        Group {
            if appState.isLogin == true {
                ContentView()
            }else{
                IntroView(shouldOpenPage: false)
            }
        }.onAppear {
        //MARK: からのユーザーを登録してしまったとき。
           //  try? Auth.auth().signOut()
            if Auth.auth().currentUser == nil {
                appState.isLogin = false
            }else{
                appState.isLogin = true
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
