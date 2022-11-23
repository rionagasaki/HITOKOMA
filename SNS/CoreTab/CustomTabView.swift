//
//  CustomTabView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/25.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var selectedTab:Tab
    @Binding var navigationTitle:String
    var body: some View {
        HStack{
            Spacer()
            ForEach(tabItems) { item in
                Button {
                    self.selectedTab = item.tab
                    self.navigationTitle = item.tab.rawValue
                } label: {
                    VStack(spacing:0){
                        Image(systemName: item.menuImage).foregroundColor(item.tab == selectedTab ? .black: .gray).symbolVariant(.fill).font(.body.bold()).frame(width: 44, height: 29)
                        Text(item.menuTitle).foregroundColor(item.tab == selectedTab ? .black: .gray).font(.caption2).lineLimit(1)
                    }
                }
                Spacer()
            }
        }.background(.white)
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
