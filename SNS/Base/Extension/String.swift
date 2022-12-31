//
//  String.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/26.
//

import Foundation

extension String {
    func isCurrentEmailFormat() -> Bool {
        let pattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let matches = regex.matches(in: self, range: NSRange(location: 0, length: self.count))
        return matches.count > 0
    }
    
    func isCurrentPasswordFormat() -> Bool {
        let pattern = "^(?=.*?[A-Za-z])(?=.*?[0-9])[A-Za-z0-9]{8,}$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let matches = regex.matches(in: self, range: NSRange(location: 0, length: self.count))
        return matches.count > 0
    }
}
