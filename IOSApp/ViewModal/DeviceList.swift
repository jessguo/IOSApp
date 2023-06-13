//
//  DeviceInfoManager.swift
//  IOSApp
//
//  Created by 郭点 on 2023/6/8.
//

import Foundation
import Moya
import SwiftyJSON

class DeviceListModal: ObservableObject {
    @Published var deviceList = [JSON]()

    func fetchData() {
        let userModal = UserManager()
        print("userId", userModal.userId)

        appProvider.request(.getDevcieList(id: userModal.userId)) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let jsonData = JSON(data)
                if jsonData["status"].intValue == 0 {
                    print("jsonData", jsonData)
                    self.deviceList = jsonData["data"].arrayValue
                }

            case .failure:
                print(result)
            }
        }
    }

    func fetchDataWrapper() {
        fetchData()
    }

    init() {
        fetchDataWrapper()
    }
}

let mockJsonDeviceList = """
    {"status":0,"message":"ok","timestamp":"2023-06-09T06:47:41.852Z","data":[{"id":"19cc819e-0df0-4fd6-9279-5a5611c55ba0","createdAt":"2023-05-17T07:29:14.028192Z","sn":"42234232432424","name":"mpm112211","userId":null,"remark":"11","supplier":"MP","collectorSn":null,"protocolNumber":null,"hardwareVersion":null,"firmwareVersion":null,"targetFirmwareVersion":null,"targetFirmwareId":null,"modelId":null,"timezone":-7,"modelData":{"id":"08f78c32-73c4-4ffa-a40a-59798b2e0f33","createdAt":"2023-04-03T02:42:45.863199Z","name":"mpm","displayName":"Mango Power M","activeFirmwareId":null,"remark":"MPM 自研 美版","region":"US","collectorModelId":null,"collection":null},"mpuMap":null,"collector":null,"data":null},{"id":"859986d9-5185-42b8-8c21-9fcd39b5c545","createdAt":"2022-11-17T10:35:13.165977Z","sn":"100200YB2B000009","name":"mei ban mpe","userId":null,"remark":null,"supplier":"MP","collectorSn":null,"protocolNumber":null,"hardwareVersion":"1.3.3","firmwareVersion":"4.1.4","targetFirmwareVersion":null,"targetFirmwareId":null,"modelId":null,"timezone":8,"modelData":{"id":"7abb2260-3970-4e3b-93a9-fac51e99bdb4","createdAt":"2022-12-13T10:03:55.401444Z","name":"mpe","displayName":"Mango Power E","activeFirmwareId":"bda9e3d9-0265-4f41-a3bb-2c95beffb516","remark":"MPE 自研 美版","region":"US","collectorModelId":"5a303243-4005-4903-9bdd-79fc1ffe8ef9","collection":"mpe"},"mpuMap":null,"collector":null,"data":{"id":"b43d4d0d-c372-4ce9-9241-35155d9ac0cf","createdAt":"2023-05-15T07:04:21.729603Z","timestamp":"2023-05-15T07:04:21.728Z","deviceId":null,"batterySoc":83,"batterySoh":0,"batteryCapacity":6700,"batteryInW":0,"batteryOutW":0,"inputTotal":0,"outputTotal":0,"acOutputTotal":0,"dcOutputTotal":0,"temperature":23,"gridInW":0,"gridOutW":0}}],"minVersion":"2.4.0"}
"""

class DeviceListModalMock: ObservableObject {
    @Published var deviceList = [JSON]()

    func fetchData() {
        let jsonData = JSON(parseJSON: mockJsonDeviceList)
        let status = jsonData["status"].intValue

        if status == 0 {
            deviceList = jsonData["data"].arrayValue
        }
    }

   
    init() {
        fetchData()
    }
}
