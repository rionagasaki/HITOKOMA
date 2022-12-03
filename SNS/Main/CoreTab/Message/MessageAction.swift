//
//  MessageAction.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/23.
//

import Foundation

internal enum MessageAction{
    case fetchAllMessages
    case recieveNewMessage(Message)
}
