//
//  ChatReducer.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/23.
//

import Foundation
import ComposableArchitecture

struct ChatReducer{
    static let reducer = Reducer<ChatState, ChatAction, ChatEnvironment>{ state, action, environment in
        switch action{
        case .loadMessage(let chats):
            return .none
        case .recieveMessage(let message):
            return .none
        case .sendMessage(let message):
            return .none
        }
    }
}
