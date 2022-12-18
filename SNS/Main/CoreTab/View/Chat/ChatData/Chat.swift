//
//  Chat.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/23.
//

import Foundation
import SwiftUI

struct Chat:Identifiable, Equatable{
    var id = UUID()
    var messageText:String?
    var massageImageURLString: String?
    var sender:Bool
    var messageDate: String
    var messageType: MessageType
}
