//
//  networktest.swift
//  UseCoreML
//
//  Created by Masayoshi Tsutsui on 2023/05/26.
//

import Foundation


import UIKit
import Alamofire

class ConfirmationViewController: UIViewController {
    
    func requestWith(image: UIImage, userId: String) {
        let url = "https://webhook.site/cd94d7bd-f6d0-4323-8e4f-af6c4c105adb"

        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]

        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }

        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            multipartFormData.append(userId.data(using: .utf8)!, withName: "moji")
        }, to: url, method: .post, headers: headers).responseString { response in
            if let statusCode = response.response?.statusCode {
                print(statusCode)
                if case 200...299 = statusCode {
                    print("正常")
                } else {
                    print("通信エラー")
                }
            }
        }
    }
    
    // このクラスの他のメソッドやUIコンポーネントなどを追加することもできます。
    // 例えば、画像選択ボタンやテキストフィールドを追加し、ユーザーが画像とユーザーIDを入力できるようにすることができます。
}
