//
//  ProfileViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/30.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    func signOut(isSuccessSignOut:@escaping ()->Void) throws{
        do {
            try? Authentication().signOut()
            isSuccessSignOut()
        }
    }
}
