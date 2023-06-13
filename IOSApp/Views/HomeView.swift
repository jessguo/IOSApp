//
//  HomeView.swift
//  IOSApp
//
//  Created by 郭点 on 2023/5/26.
//

import SwiftUI
import SwiftyJSON

struct HomeView: View {
    @EnvironmentObject var navModal: NavViewModal
    @AppStorage("user") private var userData: Data?
    @State var deviceList = [JSON]()
    @StateObject var deviceModal = DeviceListModalMock()

   
    func addBtn() -> some View {
        Button(action: {
//            self.isPresented = true
        }) {
            Image(systemName: "plus.circle.fill").font(.system(size: 27)).foregroundColor(.blue)
        }
    }

    func userBtn() -> some View {
        Button(action: {}) {
            Image(systemName: "person.circle").font(.system(size: 27)).foregroundColor(.blue)
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    if(self.deviceModal.deviceList.isEmpty ){
                        ForEach(self.deviceModal.deviceList.indices, id: \.self) { index in
                            let name = self.deviceModal.deviceList[index]["name"].stringValue
                            let batterySoh = self.deviceModal.deviceList[index]["data"]["batterySoh"].floatValue
                            let typeName = self.deviceModal.deviceList[index]["modelData"]["name"].stringValue
                            let deviceSn = self.deviceModal.deviceList[index]["sn"].stringValue
                            NavigationLink(destination: DeviceDetail(deviceSn: deviceSn)) { VStack {
                                Text(name).foregroundColor(.white).font(.title2).bold()
                                BatteryLevel(batteryLevel: Float(batterySoh))
                                Image(typeName).resizable().aspectRatio(contentMode: .fit)
                            }.frame(maxWidth: .infinity).padding(.top).padding(.horizontal).background(Color("lightBackgroundColor")).cornerRadius(15)
                            }
                        }
                    }
                    AddDevice()
                }
            }.padding(.leading)
                .padding(.trailing).navigationBarTitle("", displayMode: .inline).navigationBarItems(leading: userBtn(), trailing: addBtn())
            Spacer()
        }
    }
}

struct BatteryLevel: View {
    var batteryLevel: Float = 0
    var body: some View {
//        VStack {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 10)
                    .opacity(0.2)
                    .foregroundColor(.black)

                RoundedRectangle(cornerRadius: 10)
                    .frame(width: CGFloat(self.batteryLevel / 100) * geometry.size.width, height: 10)
                    .foregroundColor(Color("themeColor"))
            }
            Text("\(Int(self.batteryLevel))%").padding(.top).foregroundColor(.white)
        }

//        }
    }
}

struct AddDevice: View {
    var body: some View {
        NavigationLink(destination:  SearchDeviceView()){
            VStack(spacing: 20) {
                Image(systemName: "plus.circle").foregroundColor(.white).font(.system(size: 50))
                Text("Add Devicese").foregroundColor(.white).font(.system(size: 20))
            }.frame(maxWidth: .infinity).padding().background(Color("lightBackgroundColor")).cornerRadius(15)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().preferredColorScheme(.dark).environmentObject(NavViewModal()).environmentObject(UserManager())
    }
}
