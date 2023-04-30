//
//  Storage.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/04.
//

import Foundation
import UIKit
import FirebaseStorage

let storage = Storage.storage()

class RegisterStorage{
    func refisterImageToStorage(folderName: String,profileImage: UIImage,completion: @escaping (URL)-> Void){
        guard let updateImage = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let fileName = NSUUID().uuidString
        let userProfileRef = storage.reference().child(folderName).child(fileName)
        userProfileRef.putData(updateImage, metadata: nil) { metadata, error in
            if error != nil {
                print((error?.localizedDescription).orEmpty)
                return
            }
            guard metadata != nil else {
                return
            }
            userProfileRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    return
                }
                completion(downloadURL)
            }
        }
    }
}
