//
//  LoginView.swift
//  IOSApp
//
//  Created by 郭点 on 2023/5/26.
//

import Moya
import SwiftUI
import SwiftyJSON

struct LoginView: View {
    @ObservedObject var loginModal = LoginModal()
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var navModal: NavViewModal
    @AppStorage("user") private var userData: Data?


    var body: some View {
        VStack {
            LogosView()
            VStack(spacing: 30) {
                loginNameView()
                loginPasswordView()
                loginButton()
                Spacer()
            }.padding()
        }
    }

    func handlegLogin() {
        navModal.navigation(routeName: .home)
        provider.request(.login(username: loginModal.username, password: loginModal.password)){ result in
            switch result   {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let jsonData = JSON(data)
                userManager.user = jsonData
                userManager.isLoggedIn = true
                
            case .failure :
                print(result)
            }
        }
    }

    func loginNameView() -> some View {
        VStack {
            TextField("请输入邮箱", text: $loginModal.username).modifier(InputStyle())
            if !loginModal.isUsernameLengthValid {
                InputErrorView(iconName: "exclamationmark.circle.fill", text: "邮箱格式不正确")
            }
        }
    }

    func loginPasswordView() -> some View {
        VStack {
            SecureField("请输入密码", text: $loginModal.password).modifier(InputStyle())
            if !loginModal.isPasswordvalid {
                InputErrorView(iconName: "exclamationmark.circle.fill", text: "密码有误")
            }
        }
    }

    func loginButton() -> some View {
        Button(action: handlegLogin) {
            Text("登陆").frame(maxWidth: .infinity).modifier(InputStyle())
        }
    }
}

// 错误信息
struct InputErrorView: View {
    var iconName = ""
    var text = ""

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(Color(red: 251/255, green: 128/255, blue: 128/255))
            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundColor(Color(red: 251/255, green: 128/255, blue: 128/255))
            Spacer()
        }
    }
}

struct InputStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(20).foregroundColor(.white).background(Color("lightBackgroundColor")).cornerRadius(16)
    }
}

struct LogosView: View {
    var body: some View {
        Image("logo")
        Text("MANGO POWER").foregroundColor(Color.white).font(.title2)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(NavViewModal()).environmentObject(UserManager())
    }
}
