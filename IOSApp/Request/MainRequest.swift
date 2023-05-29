//
//  MainRequest.swift
//  IOSApp
//
//  Created by 郭点 on 2023/5/29.
//

import Foundation
import Moya

let token = UserDefaults.standard.string(forKey: "token_key")

enum AppService {
    case login(username: String, password: String)
    case getDeviceList(userId: String)
}

extension MyService: TargetType {
    var baseURL: URL {
        return URL(string: "https://mp-app-api-test.mangopower.com")!
    }

    var path: String {
        switch self {
        case .getDeviceList:
            return "/device/user-device-list"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getDeviceList:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .getDeviceList(userId: let userId):
            return .requestParameters(parameters: ["userId": userId], encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        [
            "app-id": "e25c6bc4-1688-44bb-80e2-6c057b20efe6",
            "Content-Type": "application/json",
            "client-id": "a9e98437-ab4c-49a0-8918-0d25d39f7fd3",
            "Token": token ?? ""
        ]
    }
}

let AppProvider = MoyaProvider<AppService>()
