//
//  NavModal.swift
//  IOSApp
//
//  Created by 郭点 on 2023/5/26.
//

import Foundation
import Combine


enum Route {
    case login
    case home
}

class NavViewModal: ObservableObject {
    @Published var currentRoute: Route = .login
    
    func navigation(routeName:Route){
        self.currentRoute = routeName
        print("Navigating to: \(routeName)")
    }
}
