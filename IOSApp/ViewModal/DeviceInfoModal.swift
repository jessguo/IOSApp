//
//  DeviceInfoManager.swift
//  IOSApp
//
//  Created by 郭点 on 2023/6/8.
//

import Foundation
import SwiftyJSON


//let mockJson = """
//{"status":0,"message":"ok","timestamp":"2023-06-05T02:20:38.453Z","data":{"id":"cd391bfc-0d4b-4407-a2c7-928a5808536a","createdAt":"2023-05-06T02:36:41.471974Z","deviceId":"e0b84798-9856-404e-be24-c38aabbfb53b","shadow":{"id":"e0b84798-9856-404e-be24-c38aabbfb53b","sn":"100202YA2B000023","state":{"emsSetting":{"boot":true,"reset":false,"sysTime":{"day":18,"hour":21,"year":22,"month":10,"minute":50,"second":21},"timerMode":false,"upsEnable":false,"timeSlices":[{"endHour":0,"endMinute":0,"startHour":0,"startMinute":0}],"chargeEnable":true,"acOutputEnable":false,"dcOutputEnable":false,"ecoReservedSoc":0,"maxChargeCurrent":15,"upsAutoChargeSoc":85,"discharge240Enable":false},"pcsSetting":{"acFrequency":60,"acOutputVolt":120},"realtimeData":{"bmsData":[{"soc":0,"temp":265,"volt":44040,"state":192,"current":0,"warning":[1,10,12],"capacity":6700}],"emsData":{"error":0,"dcPower":0,"powerPv":0,"socReal":0,"socUser":0,"warning":0,"sysState":1,"powerGrid":0,"powerLoad":0,"workState":0,"parallelInfo":{"id":0,"soc":0,"powerPv":0,"powerGrid":0,"powerLoad":0}},"pcsData":{"acVolt":5,"dcVolt":4379,"acPower":0,"acCurrent":0,"dcCurrent":66,"errorInfo":[14,28],"inletAirTemp":266,"outletAirTemp":301},"mpptData":{"inputVolt":43,"inputPower":0,"inputTotal":0,"inputCurrent":43},"collector":{"grid":{"input":{"power":0,"kwhToday":{"low":0,"high":0,"unsigned":false},"kwhTotal":{"low":0,"high":0,"unsigned":false},"kwhPeriod":{"low":0,"high":0,"unsigned":false}},"total":{"power":0,"kwhToday":{"low":0,"high":0,"unsigned":false},"kwhTotal":{"low":0,"high":0,"unsigned":false},"kwhPeriod":{"low":0,"high":0,"unsigned":false}},"output":{"power":0,"kwhToday":{"low":0,"high":0,"unsigned":false},"kwhTotal":{"low":0,"high":0,"unsigned":false},"kwhPeriod":{"low":0,"high":0,"unsigned":false}}},"load":{"power":0,"kwhToday":{"low":0,"high":0,"unsigned":false},"kwhTotal":{"low":0,"high":0,"unsigned":false},"kwhPeriod":{"low":0,"high":0,"unsigned":false}},"solar":{"volt":43,"power":0,"current":-430,"kwhToday":{"low":0,"high":0,"unsigned":false},"kwhTotal":{"low":0,"high":0,"unsigned":false},"kwhPeriod":{"low":0,"high":0,"unsigned":false}},"battery":{"soc":0,"soh":0,"input":{"power":0,"kwhToday":{"low":0,"high":0,"unsigned":false},"kwhTotal":{"low":0,"high":0,"unsigned":false},"kwhPeriod":{"low":0,"high":0,"unsigned":false}},"total":{"power":0,"kwhToday":{"low":0,"high":0,"unsigned":false},"kwhTotal":{"low":0,"high":0,"unsigned":false},"kwhPeriod":{"low":0,"high":0,"unsigned":false}},"output":{"volt":440,"power":0,"current":0,"kwhToday":{"low":0,"high":0,"unsigned":false},"kwhTotal":{"low":0,"high":0,"unsigned":false},"kwhPeriod":{"low":0,"high":0,"unsigned":false}},"capacity":6700}}}},"version":1,"collectorSn":"800800ZA2B100011"},"updateAt":"2023-05-26T08:01:13.836Z","remark":null},"minVersion":"2.4.0"}
//"""

let mockJson = """
{"status":0,"message":"ok","timestamp":"2023-06-08T08:03:38.096Z","data":{"id":"859986d9-5185-42b8-8c21-9fcd39b5c545","createdAt":"2022-11-17T10:35:13.165977Z","sn":"100200YB2B000009","name":"mei ban mpe","userId":null,"remark":null,"supplier":"MP","collectorSn":null,"protocolNumber":null,"hardwareVersion":"1.3.3","firmwareVersion":"4.1.4","targetFirmwareVersion":null,"targetFirmwareId":null,"modelId":null,"timezone":8,"modelData":{"id":"7abb2260-3970-4e3b-93a9-fac51e99bdb4","createdAt":"2022-12-13T10:03:55.401444Z","name":"mpe","displayName":"Mango Power E","activeFirmwareId":"bda9e3d9-0265-4f41-a3bb-2c95beffb516","remark":"MPE 自研 美版","region":"US","collectorModelId":"5a303243-4005-4903-9bdd-79fc1ffe8ef9","collection":"mpe"},"mpuMap":null,"collector":null,"data":{"id":"b43d4d0d-c372-4ce9-9241-35155d9ac0cf","createdAt":"2023-05-15T07:04:21.729603Z","timestamp":"2023-05-15T07:04:21.728Z","deviceId":null,"batterySoc":83,"batterySoh":0,"batteryCapacity":6700,"batteryInW":0,"batteryOutW":0,"inputTotal":0,"outputTotal":0,"acOutputTotal":0,"dcOutputTotal":0,"temperature":23,"gridInW":0,"gridOutW":0}},"minVersion":"2.4.0"}
"""

class DeviceSetting: ObservableObject {
    @Published var chargeEnable = false
    @Published var acOutputEnable = false
    @Published var dcOutputTotal = false
    @Published var maxChargeCurrent = 0
    @Published var deviceName = ""
    @Published var deviceSn = ""
    @Published var displayName = ""
    

    @Published var collectorFirmwareVersion = ""
    @Published var EMSFirmwareVersion = ""

    func fetchData() async {
        let jsonData = JSON(parseJSON: mockJson)
        let status = jsonData["status"].intValue

        if status == 0 {
            let data = jsonData["data"]
            print("DeviceSetting",data)

            DispatchQueue.main.async {
                self.collectorFirmwareVersion = data["collector"]["firmwareVersion"].stringValue
                self.EMSFirmwareVersion  = data["firmwareVersion"].stringValue
                
                self.chargeEnable = data["shadow"]["state"]["emsSetting"]["chargeEnable"].boolValue
                self.acOutputEnable = data["shadow"]["state"]["emsSetting"]["acOutputEnable"].boolValue
                self.dcOutputTotal = data["shadow"]["state"]["emsSetting"]["dcOutputTotal"].boolValue
                self.maxChargeCurrent = data["shadow"]["state"]["emsSetting"]["maxChargeCurrent"].intValue
                
                self.deviceName = data["name"].stringValue
                self.deviceSn = data["sn"].stringValue
                self.displayName = data["modelData"]["displayName"].stringValue

            }
        }
    }
    
    func editDeviceName(name:String)  {
        self.deviceName = name
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
