//
//  ContentView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/04.
//

import SwiftUI
import CoreData
import Combine


struct ContentView: View {
    @State var selectedTab: Tab = .home
    var body: some View {
        
        ZStack(alignment: .bottom){
            switch selectedTab {
            case .home:
                HomeView()
            case .search:
                SearchView()
            case .profile:
                ProfileView()
            }
            HStack{
                Spacer()
                ForEach(tabItems) { item in
                    Button {
                        self.selectedTab = item.tab
                    } label: {
                        if selectedTab == item.tab{
                            VStack(spacing:0){
                                Image(systemName: item.menuImage).foregroundColor(Color.white).symbolVariant(.fill).font(.body.bold()).frame(width: 44, height: 29)
                                Text(item.menuTitle).foregroundColor(Color.white).font(.caption2).lineLimit(1)
                            }
                            .background(alignment: .center, content: {
                                Circle().fill(.ultraThinMaterial).frame(width: 60, height: 60)
                            })
                        }else{
                            VStack(spacing:0){
                                Image(systemName: item.menuImage).foregroundColor(Color.white).symbolVariant(.fill).font(.body.bold()).frame(width: 44, height: 29)
                                Text(item.menuTitle).foregroundColor(Color.white).font(.caption2).lineLimit(1)
                            }
                        }
                    }
                    Spacer()
                }
            }.padding(.bottom,20).padding(.top,20)
                
                .background(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing).opacity(0.6)).background(.ultraThinMaterial).cornerRadius(36).overlay(RoundedRectangle(cornerRadius: 34).stroke(Color.white, lineWidth: 0.5)).frame(maxHeight: .infinity,alignment: .bottom).ignoresSafeArea()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
