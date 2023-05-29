//
//  HomeView.swift
//  IOSApp
//
//  Created by 郭点 on 2023/5/26.
//

import SwiftUI
import SwiftyJSON

struct HomeView: View {
    @EnvironmentObject var navModal:NavViewModal
    @AppStorage("user") private var userData: Data?
    
    private func userDataToString() -> String {
           guard let data = userData, let userString = String(data: data, encoding: .utf8) else {
               return "No data available"
           }
           return userString
       }

    var body: some View {
        VStack {
            Text("\(userDataToString())")
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(NavViewModal()).environmentObject(UserManager())
    }
}
