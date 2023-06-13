//
//  BingSNView.swift
//  IOSApp
//
//  Created by 郭点 on 2023/6/13.
//

import SwiftUI

struct BingSNView: View {
    var deviceName: String = ""
    var imgSrc = ""
    @Binding var showSheet: Bool
    @State var snNummber = ""
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.showSheet.toggle()
                }) {
                    Image(systemName: "xmark.circle").foregroundColor(.white).font(.title2)
                }
                Spacer()
                Text("新增设备").font(.title2)
                Spacer()
                
            }.padding(.bottom, 20)
            Text(deviceName).font(.title2).bold()
            Image(imgSrc)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("SN").font(.title2)
                    Spacer()
                }
                HStack {
                    TextField("", text: $snNummber  ).keyboardType(.decimalPad)
                    Spacer()
                }
              
                Text("Device serial number.").foregroundColor(.gray)
            }.padding(.bottom, 40)
            
            Button(action: {
                // 操作
                print("登录成功")

            }) {
                // 按钮样式
                Text("添加设备")
                    .font(.system(size: 14))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(5)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct BingSNView_Previews: PreviewProvider {
    static var previews: some View {
        BingSNView(deviceName: "Mango Power E", imgSrc: "mpe", showSheet: .constant(true)).preferredColorScheme(.dark)
    }
}
