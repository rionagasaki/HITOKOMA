//
//  ChatAction.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/23.
//

import Foundation

internal enum ChatAction{
    case loadMessage([Chat])
    case sendMessage(String)
    case recieveMessage(String)
}
