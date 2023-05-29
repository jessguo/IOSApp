//
//  UserManager.swift
//  IOSApp
//
//  Created by 郭点 on 2023/5/27.
//

import SwiftUI
import Combine
import SwiftyJSON

class UserManager: ObservableObject {
    @Published var user: JSON? {
        didSet {
            if let user = user {
                if let data = try? user.rawData() {
                    UserDefaults.standard.set(data, forKey: "user")
                }
            } else {
                UserDefaults.standard.removeObject(forKey: "user")
            }
        }
    }

    @Published var isLoggedIn = false {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        }
    }

    init() {
        if let data = UserDefaults.standard.data(forKey: "user"), let jsonData = try? JSON(data: data) {
            self.user = jsonData
        }

        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
}
