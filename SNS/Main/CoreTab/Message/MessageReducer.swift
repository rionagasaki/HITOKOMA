//
//  MessageReducer.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/23.
//

import Foundation
import ComposableArchitecture

struct MessageReducer{
    static let reducer = Reducer<MessageState, MessageAction, MessageEnvironment>{ state, action, environment in
        switch action {
        case .fetchAllMessages:
            return .none
        case .recieveNewMessage(let message):
            return .none
        }
    }
}
