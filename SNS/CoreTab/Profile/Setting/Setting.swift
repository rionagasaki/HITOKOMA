//
//  Setting.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/18.
//

import Foundation
import SwiftUI

struct Setting:Identifiable {
    var id = UUID()
    var settingName: String
    var settingImage: String
    var handler:() -> Void
}
