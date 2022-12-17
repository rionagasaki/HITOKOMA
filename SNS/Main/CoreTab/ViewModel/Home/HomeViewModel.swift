//
//  HomeViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/15.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var selection: Int = 0
    @Published var isRefreshing: Bool = false
    @Published var timer: Timer?
    
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            withAnimation {
                if self.selection >= 2 {
                    self.selection = 0
                } else {
                    self.selection += 1
                }
            }
        }
    }
    
    func invalidateTimer(){
        timer?.invalidate()
    }
}
