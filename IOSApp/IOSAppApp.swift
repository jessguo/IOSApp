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
//    init() {
//           UINavigationBar.appearance().barTintColor = .clear
//           UINavigationBar.appearance().backgroundColor = .clear
//           UITableView.appearance().backgroundColor = UIColor(named: "backgroundColor")
//           UITableViewCell.appearance().backgroundColor = UIColor(named: "backgroundColor")
//       }
    var body: some Scene {
        WindowGroup {
            ContentView().preferredColorScheme(.dark)
                .background(Color("backgroundColor").ignoresSafeArea()).environmentObject(router)
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
