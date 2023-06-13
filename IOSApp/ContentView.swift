//
//  ContentView.swift
//  IOSApp
//
//  Created by 郭点 on 2023/5/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navModal: NavViewModal

    var body: some View {
        NavigationView {
            switch navModal.currentRoute {
            case .home:
                HomeView()
            case .login:
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(NavViewModal()).environmentObject(UserManager())
    }
}
