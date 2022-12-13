//
//  BackgroundClearView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/07.
//

import Foundation
import UIKit
import SwiftUI

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        Task {
            view.superview?.superview?.backgroundColor = .white.withAlphaComponent(0.95)
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    typealias UIViewType = UIView
    
    
}
