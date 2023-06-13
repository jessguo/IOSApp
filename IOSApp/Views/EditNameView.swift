//
//  EditNameView.swift
//  IOSApp
//
//  Created by 郭点 on 2023/6/8.
//

import SwiftUI

struct EditNameView: View {
    @Environment(\.presentationMode) var mode

    @State var name: String = ""
    let editName: (String) -> Void

    init(initialName: String, editName: @escaping (String) -> Void) {
        _name = State(initialValue: initialName)
        self.editName = editName
    }

    func BackBtn() -> some View {
        Button("取消") {
            self.mode.wrappedValue.dismiss()
        }.padding()
    }

    func SaveBtn() -> some View {
        Button("修改") {
            editName(name)
            self.mode.wrappedValue.dismiss()

        }.padding()
    }

    var body: some View {
        VStack {
            VStack {
                Group {
                    TextField("标题", text: $name).padding().foregroundColor(.white).preferredColorScheme(.dark).background(Color("lightBackgroundColor"))
                }
                .background(Color.white)
                .cornerRadius(10)
                .padding()
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackBtn(), trailing: SaveBtn())
    }
}

struct EditNameView_Previews: PreviewProvider {
    static var deviceSetting = DeviceSetting()
    static var previews: some View {
        EditNameView(initialName: "测试", editName: deviceSetting.editDeviceName).preferredColorScheme(.dark).background(Color("backgroundColor"))
            .previewLayout(.sizeThatFits)
    }
}
