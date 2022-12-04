//
//  MessageListData.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/03.
//

import Foundation

struct MessageListData: Identifiable{
    let id = UUID()
    let lessonImage: String
    let lessonName: String
    let lessonContents: String
    let lessonBudgets: Int
    let lessonID: String
    let senderIconImage: String
    let senderName: String
    let senderUid: String
    let lastMessage: String
    let lastMessageDate: String
}
