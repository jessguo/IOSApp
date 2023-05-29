//
//  LoginModal.swift
//  IOSApp
//
//  Created by 郭点 on 2023/5/26.
//

import Combine
import Foundation

class LoginModal: ObservableObject {
    // 输入
    @Published var username = ""
    @Published var password = ""
    
    // 输出
    @Published var isUsernameLengthValid = false
    @Published var isUsernameCheckValid = false
    @Published var isPasswordvalid = false
    
    private var cancellabeSet: Set<AnyCancellable> = []
    
    // init
    init() {
        $username.receive(on: RunLoop.main).map { username in
            username.count >= 8
        }.assign(to: \.isUsernameLengthValid, on: self)
            .store(in: &cancellabeSet)
        
        $password.receive(on: RunLoop.main).map { password in
            password.count >= 8
        }.assign(to: \.isPasswordvalid, on: self)
            .store(in: &cancellabeSet)
    }
}
