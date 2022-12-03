//
//  Chat.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/23.
//

import Foundation

struct Chat:Identifiable, Equatable{
    var id = UUID()
    var messageText:String
    var sender:Bool
    var messageDate: String
}
