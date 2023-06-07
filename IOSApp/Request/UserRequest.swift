//
//  Request.swift
//  Mymoya
//
//  Created by 郭点 on 2023/5/8.
//

import Foundation
import Moya
import SwiftyJSON

enum UserService {
    case login(username: String, password: String)
}

enum AppService {
    case getDevcieList(id: String)
}

extension UserService: TargetType {
    var baseURL: URL {
        return URL(string: "https://mp-api-test.mangopower.com")!
    }

    var path: String {
        switch self {
        case .login:
            return "/account/login"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .login(let username, let password):
            return .requestParameters(parameters: ["username": username, "password": password], encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        [
            "app-id": "e25c6bc4-1688-44bb-80e2-6c057b20efe6",
            "Content-Type": "application/json",
            "client-id": "a9e98437-ab4c-49a0-8918-0d25d39f7fd3",
//            "Token": token ?? ""
        ]
    }
}

extension AppService: TargetType {
    var baseURL: URL {
        return URL(string: "https://mp-app-api-test.mangopower.com")!
    }

    var path: String {
        switch self {
        case .getDevcieList:
            return "/device/user-device-list"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getDevcieList:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .getDevcieList(let id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        let userManager = UserManager()
        let token = userManager.user?["token"].stringValue
    

        return [
            "app-id": "e25c6bc4-1688-44bb-80e2-6c057b20efe6",
            "Content-Type": "application/json",
            "client-id": "a9e98437-ab4c-49a0-8918-0d25d39f7fd3",
            "Token": token ?? ""
        ]
    }
}

let userProvider = MoyaProvider<UserService>()
let appProvider = MoyaProvider<AppService>()
