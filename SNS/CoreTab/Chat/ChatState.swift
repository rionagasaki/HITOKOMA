//
//  ChatState.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/23.
//

import Foundation
import ComposableArchitecture

struct ChatState: Equatable{
    var allMessages:[Chat]
    var enabledSendButton:Bool
    var messageText:String
    
    static var initial:ChatView {
        return ChatView(store: Store(initialState: ChatState(allMessages: [], enabledSendButton: false, messageText: ""), reducer: ChatReducer.reducer, environment: ChatEnvironment()))
    }
}
