//
//  Firmware.swift
//  IOSApp
//
//  Created by 郭点 on 2023/6/7.
//

import SwiftUI
import SwiftyJSON

let upgradeJson = """
{"status":0,"message":"ok","timestamp":"2023-06-08T03:43:38.056Z","data":{"update":true,"ems":{"update":true,"type":"ems","firmware":{"id":"bda9e3d9-0265-4f41-a3bb-2c95beffb516","createdAt":"2023-02-16T02:56:21.178372Z","name":"mpe4.2.5-2_v4_2_5","type":"ems","version":"4.2.5","path":"/device/firmware/mpe4.2.5-2_v4_2_5.bin","remark":"","md5":"716718ae5bee37a54fd551ef4d9263c0","size":107304,"sha256":"afa34f32557c631e253f168ad0a3c746ce9fe41e4477015b079bb89b3fc6fbfb","enable":true,"deleted":false,"versionNumber":1028},"unwrappingSerializer":false,"delegatee":null},"collector":{"update":false,"type":"collector","firmware":null,"unwrappingSerializer":false,"delegatee":null},"unwrappingSerializer":false,"delegatee":null},"minVersion":"2.4.0"}
"""

let infoDataJson = """
{"status":0,"message":"ok","timestamp":"2023-06-08T05:45:08.020Z","data":{"id":"e0b84798-9856-404e-be24-c38aabbfb53b","createdAt":"2023-04-26T10:26:32.492108Z","sn":"100202YA2B000023","name":"hdhdheujdbskkdnjdj23","userId":null,"remark":"mpe","supplier":"MP","collectorSn":"800800ZA2B100011","protocolNumber":null,"hardwareVersion":"1.3.3","firmwareVersion":"4.2.1","targetFirmwareVersion":null,"targetFirmwareId":null,"modelId":null,"timezone":9,"modelData":{"id":"7abb2260-3970-4e3b-93a9-fac51e99bdb4","createdAt":"2022-12-13T10:03:55.401444Z","name":"mpe","displayName":"Mango Power E","activeFirmwareId":"bda9e3d9-0265-4f41-a3bb-2c95beffb516","remark":"MPE 自研 美版","region":"US","collectorModelId":"5a303243-4005-4903-9bdd-79fc1ffe8ef9","collection":"mpe"},"mpuMap":null,"collector":{"id":"0232cf6c-e2df-4f62-b7fd-22f4d5872308","createdAt":"2022-10-22T12:33:57.598796Z","sn":"800800ZA2B100011","model":null,"remark":null,"status":2,"firmwareVersion":"1.1.9","macAddress":"58:CF:79:14:B4:64","lastOnlineAt":"2023-05-26T08:00:56.639Z","lastOfflineAt":"2023-05-26T08:03:28.824Z","offlineReason":"Abnormal offline","lastActiveAt":"2023-05-26T08:01:13.841Z","targetFirmwareId":null,"targetFirmwareUpdateForce":false,"iotPlatform":"aws","modelId":"5a303243-4005-4903-9bdd-79fc1ffe8ef9"},"data":{"id":"309daeec-a20b-4317-b681-a265adfedad1","createdAt":"2023-05-26T08:01:13.839141Z","timestamp":"2023-05-26T08:01:13.839Z","deviceId":null,"batterySoc":0,"batterySoh":0,"batteryCapacity":6700,"batteryInW":0,"batteryOutW":0,"inputTotal":0,"outputTotal":0,"acOutputTotal":0,"dcOutputTotal":0,"temperature":26,"gridInW":0,"gridOutW":0}},"minVersion":"2.4.0"}
"""

class upgradeData: ObservableObject {
    @Published var newCollectorFirmwareVersion = ""
    @Published var newEMSFirmwareVersion = ""
    @Published var isShowUpdate = false

    func fetchData() async {
        let jsonData = JSON(parseJSON: upgradeJson)
        let status = jsonData["status"]

        if status == 0 {
            self.newCollectorFirmwareVersion = jsonData["data"]["collector"]["firmware"]["version"].stringValue
            self.newEMSFirmwareVersion = jsonData["data"]["ems"]["firmware"]["version"].stringValue
            self.isShowUpdate = jsonData["data"]["update"].boolValue
        }
    }

    func fetchDataWrapper() {
           Task {
               await self.fetchData()
           }
       }

    init() {
        fetchDataWrapper()
    }
}

class infoData: ObservableObject {
    @Published var collectorFirmwareVersion = ""
    @Published var EMSFirmwareVersion = ""

    func fetchData() async {
        let jsonData = JSON(parseJSON: infoDataJson)
        let status = jsonData["status"].intValue

        if status == 0 {
            self.collectorFirmwareVersion = jsonData["data"]["collector"]["firmwareVersion"].stringValue
            self.EMSFirmwareVersion = jsonData["data"]["firmwareVersion"].stringValue
        }
    }
    
    func fetchDataWrapper() {
           Task {
               await self.fetchData()
           }
       }

    init() {
        fetchDataWrapper()
    }

}

struct FirmwareView: View {
    @StateObject var deviceInfo = infoData()
    @StateObject var upgradeInfo = upgradeData()

    var body: some View {
        
        ScrollView {
            if self.upgradeInfo.isShowUpdate {
                Image(systemName: "info.circle").font(.system(size: 80)).foregroundColor(.yellow).padding(40)

            } else {
                Image(systemName: "checkmark.circle").font(.system(size: 80)).foregroundColor(.green).padding(40)
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Section(header: Text("Version").font(.title2).foregroundColor(.white).bold()) {
                    HStack {
                        Text("Wi-Fi").foregroundColor(.white)
                        Spacer()
                        Text(self.deviceInfo.collectorFirmwareVersion).foregroundColor(.white)
                    }
                    Divider().background(Color.gray)
                    HStack {
                        Text("EMS").foregroundColor(.white)
                        Spacer()
                        Text(self.deviceInfo.EMSFirmwareVersion).foregroundColor(.white)
                    }
                    Divider().background(Color.gray)
                }
                
                if self.upgradeInfo.isShowUpdate {
                    Section(header: Text("New Version").font(.title2).foregroundColor(.white).bold()) {
                        HStack {
                            Text("EMS").foregroundColor(.white)
                            Spacer()
                            Text("4.2.1").foregroundColor(.white)
                        }
                        Divider().background(Color.gray)

                    }.listRowBackground(Color.clear)

                    Button(action: {
                      
                    }) {
                        Text("Upgrade").foregroundColor(.white).frame(maxWidth: .infinity).padding().overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 2)
                        )
                    }.padding(.top, 30)
                }
            }

        }.padding()
    }
}

struct Firmware_Previews: PreviewProvider {
    static var previews: some View {
        FirmwareView().background(Color("backgroundColor"))
            .previewLayout(.sizeThatFits)
    }
}
