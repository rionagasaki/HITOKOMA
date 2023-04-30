//
//  UIImage.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/27.
//

import Foundation
import UIKit

extension UIImage {
    public convenience init?(url: String) {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            self.init(data: data)
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        self.init()
    }
}
