//
//  RootView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/22.
//

import SwiftUI
import UIKit

class AppState: ObservableObject {
    @Published var isLogin = false
    @Published var isLoading = false
}
