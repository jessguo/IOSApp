//
//  HomeView.swift
//  IOSApp
//
//  Created by 郭点 on 2023/5/26.
//

import SwiftUI
import SwiftyJSON

let stringArray = """
{"status":0,"message":"ok","timestamp":"2023-05-30T07:58:31.101Z","data":[{"id":"19cc819e-0df0-4fd6-9279-5a5611c55ba0","createdAt":"2023-05-17T07:29:14.028192Z","sn":"42234232432424","name":"mpm112211","userId":null,"remark":"11","supplier":"MP","collectorSn":null,"protocolNumber":null,"hardwareVersion":null,"firmwareVersion":null,"targetFirmwareVersion":null,"targetFirmwareId":null,"modelId":null,"timezone":-7,"modelData":{"id":"08f78c32-73c4-4ffa-a40a-59798b2e0f33","createdAt":"2023-04-03T02:42:45.863199Z","name":"mpm","displayName":"Mango Power M","activeFirmwareId":null,"remark":"MPM 自研 美版","region":"US","collectorModelId":null,"collection":null},"mpuMap":null,"collector":null,"data":null},{"id":"4133da1b-71f7-4b72-975e-cb3553323e1e","createdAt":"2023-05-12T10:13:50.811169Z","sn":"12123123121","name":"mpm1","userId":null,"remark":"11123123123123123123123123","supplier":"MP","collectorSn":null,"protocolNumber":null,"hardwareVersion":null,"firmwareVersion":null,"targetFirmwareVersion":null,"targetFirmwareId":null,"modelId":null,"timezone":8,"modelData":{"id":"08f78c32-73c4-4ffa-a40a-59798b2e0f33","createdAt":"2023-04-03T02:42:45.863199Z","name":"mpm","displayName":"Mango Power M","activeFirmwareId":null,"remark":"MPM 自研 美版","region":"US","collectorModelId":null,"collection":null},"mpuMap":null,"collector":null,"data":null},{"id":"e0b84798-9856-404e-be24-c38aabbfb53b","createdAt":"2023-04-26T10:26:32.492108Z","sn":"100202YA2B000023","name":"hdhdheujdbskkdnjdj23","userId":null,"remark":"mpe","supplier":"MP","collectorSn":"800800ZA2B100011","protocolNumber":null,"hardwareVersion":"1.3.3","firmwareVersion":"4.2.1","targetFirmwareVersion":null,"targetFirmwareId":null,"modelId":null,"timezone":8,"modelData":{"id":"7abb2260-3970-4e3b-93a9-fac51e99bdb4","createdAt":"2022-12-13T10:03:55.401444Z","name":"mpe","displayName":"Mango Power E","activeFirmwareId":"bda9e3d9-0265-4f41-a3bb-2c95beffb516","remark":"MPE 自研 美版","region":"US","collectorModelId":"5a303243-4005-4903-9bdd-79fc1ffe8ef9","collection":"mpe"},"mpuMap":null,"collector":{"id":"0232cf6c-e2df-4f62-b7fd-22f4d5872308","createdAt":"2022-10-22T12:33:57.598796Z","sn":"800800ZA2B100011","model":null,"remark":null,"status":2,"firmwareVersion":"1.1.9","macAddress":"58:CF:79:14:B4:64","lastOnlineAt":"2023-05-26T08:00:56.639Z","lastOfflineAt":"2023-05-26T08:03:28.824Z","offlineReason":"Abnormal offline","lastActiveAt":"2023-05-26T08:01:13.841Z","targetFirmwareId":null,"targetFirmwareUpdateForce":false,"iotPlatform":"aws","modelId":"5a303243-4005-4903-9bdd-79fc1ffe8ef9"},"data":{"id":"309daeec-a20b-4317-b681-a265adfedad1","createdAt":"2023-05-26T08:01:13.839141Z","timestamp":"2023-05-26T08:01:13.839Z","deviceId":null,"batterySoc":0,"batterySoh":30,"batteryCapacity":6700,"batteryInW":0,"batteryOutW":0,"inputTotal":0,"outputTotal":0,"acOutputTotal":0,"dcOutputTotal":0,"temperature":26,"gridInW":0,"gridOutW":0}},{"id":"92972f8b-852b-4ae9-9e80-61cb9ce4f4b7","createdAt":"2023-04-13T10:17:59.312863Z","sn":"800800ZA2B100020","name":"mpm-test01—）dd@qq.co","userId":null,"remark":"MPM","supplier":"MP","collectorSn":"800800ZA2B100020","protocolNumber":null,"hardwareVersion":null,"firmwareVersion":null,"targetFirmwareVersion":null,"targetFirmwareId":null,"modelId":null,"timezone":8,"modelData":{"id":"08f78c32-73c4-4ffa-a40a-59798b2e0f33","createdAt":"2023-04-03T02:42:45.863199Z","name":"mpm","displayName":"Mango Power M","activeFirmwareId":null,"remark":"MPM 自研 美版","region":"US","collectorModelId":null,"collection":null},"mpuMap":null,"collector":{"id":"55f48fad-d2d2-453d-a71c-5f271487b68f","createdAt":"2023-04-13T10:17:31.96762Z","sn":"800800ZA2B100020","model":null,"remark":null,"status":2,"firmwareVersion":"2.0.3","macAddress":"58:CF:79:09:14:7C","lastOnlineAt":"2023-04-23T07:58:33.716Z","lastOfflineAt":"2023-04-23T08:38:47.715Z","offlineReason":"Abnormal offline","lastActiveAt":"2023-04-23T08:36:32.758Z","targetFirmwareId":null,"targetFirmwareUpdateForce":false,"iotPlatform":"aws","modelId":"5a303243-4005-4903-9bdd-79fc1ffe8ef9"},"data":null}],"minVersion":"2.4.0"}
"""

let jsonData = JSON(parseJSON: stringArray)

struct HomeView: View {
    @EnvironmentObject var navModal: NavViewModal
    @AppStorage("user") private var userData: Data?
    @State var deviceList = [JSON]()

    private func userDataToString() -> String {
        guard let data = userData, let userString = String(data: data, encoding: .utf8) else {
            return "No data available"
        }
        return userString
    }

//    private func getListData() {
//        guard let unwrappedUserData = userData else {
//            print("userData is nil")
//            return
//        }
//        do {
//            let json = try JSON(data: unwrappedUserData)
//            appProvider.request(.getDevcieList(id: json["id"].stringValue)) { result in
//                switch result {
//                case let .success(moyaResponse):
//                    let data = moyaResponse.data
//                    let jsonData = JSON(data)
//                    if jsonData["status"].intValue == 0 {
//                        print(jsonData["data"])
    ////                        self.deviceList = jsonData["data"].arrayValue
//                    }
//
//                case .failure:
//                    print(result)
//                }
//            }
//        } catch {
//            print("Error parsing JSON:", error.localizedDescription)
//        }
//    }

    func getListData() {
        let json = JSON(parseJSON: stringArray)
        let status = json["data"].intValue
        guard status == 0 else {
            print("none")
            return
        }
        self.deviceList = json["data"].arrayValue
    }
    func addBtn() -> some View {
        Button(action:{
//            self.isPresented = true
        }){
            Image(systemName: "plus.circle.fill").font(.system(size:27)).foregroundColor(.blue)
        }
    }
    
    func userBtn() -> some View {
        Button(action:{
            
        }){
            Image(systemName: "person.circle").font(.system(size:27)).foregroundColor(.blue)

        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(self.deviceList.indices, id: \.self) { index in
                        if let name = deviceList[index]["name"].string {
                            let batterySoh = self.deviceList[index]["data"]["batterySoh"].floatValue
                            let typeName = self.deviceList[index]["modelData"]["name"].stringValue
                            let deviceSn = self.deviceList[index]["sn"].stringValue
                            NavigationLink(destination: DeviceDetail(deviceSn: deviceSn)) {VStack() {
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
                .padding(.trailing).navigationBarTitle("",displayMode: .inline).navigationBarItems(leading: userBtn() ,trailing: addBtn() )
            Spacer()


        }.onAppear {
            self.getListData()
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
        VStack(spacing: 20) {
            Image(systemName:  "plus.circle").foregroundColor(.white).font(.system(size:50))
            Text("Add Devicese").foregroundColor(.white).font(.system(size:20))
        }.frame(maxWidth: .infinity).padding().background(Color("lightBackgroundColor")).cornerRadius(15)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("backgroundColor").ignoresSafeArea() // 1
            HomeView().environmentObject(NavViewModal()).environmentObject(UserManager())
        }
    }
}
