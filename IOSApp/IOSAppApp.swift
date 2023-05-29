//
//  IOSAppApp.swift
//  IOSApp
//
//  Created by 郭点 on 2023/5/26.
//

import SwiftUI
import SwiftyJSON
import SwiftyJSON

@main
struct IOSAppApp: App {
    @StateObject private var router = NavViewModal()
    @StateObject private var userManager = UserManager()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(router)
                .environmentObject(userManager).onAppear {
                    print(userManager.isLoggedIn)
                    if userManager.isLoggedIn {
                        router.navigation(routeName: Route.home)
                    }
//                    print(JSON(userManager.user))

                }
        }
    }
}
