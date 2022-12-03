//
//  MessageState.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/23.
//

import Foundation
import ComposableArchitecture

struct MessageState:Equatable {
    var loadAllMessages:[Message]
    
    static var initial:MessageView {
        return MessageView(store: Store(initialState: MessageState(loadAllMessages: []), reducer: MessageReducer.reducer, environment: MessageEnvironment()))
    }
}
