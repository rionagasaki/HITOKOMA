    //
//  OpenSourceLicenSeView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/03.
//

import SwiftUI

struct OpenSourceLicenSeView: View {
    private let openSounrce = [
        OpenSource(
            name: "R.swift",
            description: "Get strong typed, autocompleted resources like images, fonts and segues in Swift projects"
        ),
        OpenSource(
            name: "PKHUD",
            description: "A Swift based reimplementation of the Apple HUD (Volume, Ringer, Rotation,…) for iOS 8 and up."
        ),
        OpenSource(
            name: "PartialSheet",
            description: "A SwiftUI Partial Sheet fully customizable with dynamic height"
        ),
        OpenSource(
            name: "Firebase SDK for Apple App Development",
            description: "This repository contains all Apple platform Firebase SDK source except FirebaseAnalytics."
        )
    ]
    
    var body: some View {
        List(openSounrce) { source in
            VStack(alignment: .leading, spacing: .zero) {
                Text(source.name)
                    .fontWeight(.medium)
                    .font(.system(size: 15))
                    .padding(.horizontal, 8)
                Text(source.description)
                    .fontWeight(.light)
                    .font(.system(size: 12))
                    .padding(.top, 5)
                    .padding(.horizontal, 8)
            }
        }
        .navigationTitle("オープンソースライブラリ")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OpenSourceLicenSeView_Previews: PreviewProvider {
    static var previews: some View {
        OpenSourceLicenSeView()
    }
}

struct OpenSource: Identifiable {
    let id = UUID()
    let name: String
    let description: String
}
