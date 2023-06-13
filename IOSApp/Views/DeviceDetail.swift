//
//  DetailView.swift
//  IOSApp
//
//  Created by 郭点 on 2023/6/3.
//

import SwiftUI
import SwiftyJSON

let realDataJSON = """
{"status":0,"message":"ok","timestamp":"2023-06-05T03:28:20.129Z","data":{"id":"e0b84798-9856-404e-be24-c38aabbfb53b","createdAt":"2023-04-26T10:26:32.492108Z","sn":"100202YA2B000023","name":"hdhdheujdbskkdnjdj23","userId":null,"remark":"mpe","supplier":"MP","collectorSn":"800800ZA2B100011","protocolNumber":null,"hardwareVersion":"1.3.3","firmwareVersion":"4.2.1","targetFirmwareVersion":null,"targetFirmwareId":null,"modelId":null,"timezone":8,"modelData":{"id":"7abb2260-3970-4e3b-93a9-fac51e99bdb4","createdAt":"2022-12-13T10:03:55.401444Z","name":"mpe","displayName":"Mango Power E","activeFirmwareId":"bda9e3d9-0265-4f41-a3bb-2c95beffb516","remark":"MPE 自研 美版","region":"US","collectorModelId":"5a303243-4005-4903-9bdd-79fc1ffe8ef9","collection":"mpe"},"mpuMap":null,"collector":{"id":"0232cf6c-e2df-4f62-b7fd-22f4d5872308","createdAt":"2022-10-22T12:33:57.598796Z","sn":"800800ZA2B100011","model":null,"remark":null,"status":2,"firmwareVersion":"1.1.9","macAddress":"58:CF:79:14:B4:64","lastOnlineAt":"2023-05-26T08:00:56.639Z","lastOfflineAt":"2023-05-26T08:03:28.824Z","offlineReason":"Abnormal offline","lastActiveAt":"2023-05-26T08:01:13.841Z","targetFirmwareId":null,"targetFirmwareUpdateForce":false,"iotPlatform":"aws","modelId":"5a303243-4005-4903-9bdd-79fc1ffe8ef9"},"data":{"id":"309daeec-a20b-4317-b681-a265adfedad1","createdAt":"2023-05-26T08:01:13.839141Z","timestamp":"2023-05-26T08:01:13.839Z","deviceId":null,"batterySoc":0,"batterySoh":0,"batteryCapacity":6700,"batteryInW":0,"batteryOutW":0,"inputTotal":0,"outputTotal":2,"acOutputTotal":0,"dcOutputTotal":0,"temperature":26,"gridInW":0,"gridOutW":0}},"minVersion":"2.4.0"}
"""
let speedListMap: [String: [String]] = [
    "MPUUS": ["10A", "15A", "20A"],
    "MPUEU": ["10A", "15A", "20A"],
    "MPEUS": ["10A", "15A", "30A"],
    "MPEEU": ["5A", "10A", "15A"]
]


class RealTimeDataInfo: ObservableObject {
    @Published var inputTotal = 0
    @Published var outputTotla = 0
    @Published var temperature = 0

    func fetchData() async {
        let json = JSON(parseJSON: realDataJSON)
        let status = json["data"].intValue
        guard status == 0 else {
            print("error")
            return
        }
        let dataJSON = json["data"]
        
        DispatchQueue.main.async {
            self.inputTotal = dataJSON["data"]["inputTotal"].intValue
            self.outputTotla = dataJSON["data"]["outputTotal"].intValue
            self.temperature = dataJSON["data"]["temperature"].intValue
        }
    }

    init() {
        Task {
            await self.fetchData()
        }
    }
}

struct SpeedObj: Codable {
    var id = UUID()
    var speed: String
    var Text: String
}

struct DeviceDetail: View {
    let deviceSn: String
    let deivceImage: String = "mpe"
    @State var dataJSON = JSON()
    @StateObject var deviceSetting = DeviceSetting()
    @StateObject var realTimeDataInfo = RealTimeDataInfo()
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    @State var deviceInfo = JSON()
    @State var speedList = speedListMap["MPUUS"]
    @Environment(\.presentationMode) var mode

    var body: some View {
//        NavigationView {
            ScrollView {
                Image(self.deivceImage).scaledToFit().padding(.bottom, 30)
                LazyVGrid(columns: self.gridItemLayout, spacing: 6) {
                    SmallBoxView(iconSrc: "powerplug", dataValue: self.realTimeDataInfo.inputTotal, unit: "W", subString: "input")
                    SmallBoxView(iconSrc: "circle.circle", dataValue: self.realTimeDataInfo.outputTotla, unit: "W", subString: "output")
                    SmallBoxView(iconSrc: "thermometer.low", dataValue: self.realTimeDataInfo.temperature, unit: "F", subString: "Temp")
                }.padding(.bottom, 10)
                LongBox(label: "Quick Charge", icon: self.deviceSetting.chargeEnable ? "ACCharging-on" : "ACCharging-off", isOn: self.$deviceSetting.chargeEnable)
                LongBox(label: "AC Output", icon: self.deviceSetting.acOutputEnable ? "ACOutput-on" : "ACOutput-off", isOn: self.$deviceSetting.acOutputEnable)
                LongBox(label: "DC Output", icon: self.deviceSetting.dcOutputTotal ? "DCOutput-on" : "DCOutput-off", isOn: self.$deviceSetting.dcOutputTotal)

                SpeedBox(speedList: self.speedList ,speedValue : $deviceSetting.maxChargeCurrent)
                BackupBox()
            }.padding(8).navigationBarBackButtonHidden(true).navigationBarItems(leading: Button(action:{
                self.mode.wrappedValue.dismiss()
            }){
                Text("back").foregroundColor(.white)
            },trailing: NavigationLink(destination: Setting()){
                Text("setting").foregroundColor(.white)
            })
        
    }
}

struct BackupBox: View {
    @State var mode = "backup"
    @State var modeList = ["backup", "timemode"]
    @State var speedListPicks = ["95%", "90%", "85%"]
    @State var speed = "95%"
    @State private var startTime = Date()
    @State private var endTime = Date()
    var body: some View {
        VStack {
            Picker("modal", selection: self.$mode) {
                ForEach(self.modeList, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            Divider().background(Color.white)
            if self.mode == "backup" {
                VStack {
                    HStack {
                        Image("ACOutput-off").scaledToFit().padding(.trailing, 10)
                        Text("Backup Battery Capacity")
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "power")
                        }
                    }
                    Picker("modal", selection: $speed) {
                        ForEach(self.speedListPicks, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
               
            } else {
                VStack{
                    HStack {
                        Image("ACOutput-off").scaledToFit().padding(.trailing, 10)
                        Text("Time mode")
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "power")
                        }
                    }
                        HStack {
                            Spacer()
                            DatePicker("开始时间", selection: $startTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .datePickerStyle(.graphical)
                            
                            Spacer()
                            DatePicker("结束时间", selection: $endTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .datePickerStyle(.graphical)
                            Spacer()
                        }
                }
            }
        }.padding(20)
            .background(Color("lightBackgroundColor"))
            .cornerRadius(12).padding(.bottom, 10)
    }
}

struct SpeedBox: View {
    var speedList = speedListMap["MPUUS"]
    @Binding var speedValue : Int
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image("ACOutput-off").scaledToFit().padding(.trailing, 10)
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Charging Speed").lineLimit(1)
                        Text("Max AC Input Current").bold().font(.title3)
                    }
                    Spacer()
                }
            }

            Divider().background(Color.white)

            LazyVGrid(columns: self.gridItemLayout, spacing: 6) {
                if let speedList = self.speedList {
                    ForEach(speedList.indices, id: \.self) { index in
                        SpeedBoxRation(speed: speedList[index], index: index, speedValue: $speedValue)
                    }
                }
            }.padding(.vertical, 20)

        }.padding(20)
            .background(Color("lightBackgroundColor"))
            .cornerRadius(12).padding(.bottom, 10)
    }
}

struct SpeedBoxRation: View {
//    var isActive = false
    let speed: String
    let index: Int
    @Binding var  speedValue : Int


    private var indexText: String {
        if self.index == 0 {
            return "Low"
        }
        if self.index == 1 {
            return "Middle"
        }
        if self.index == 2 {
            return "Hight"
        }
        return ""
    }
    
    private var isActive:Bool {
        if speedValue ==  Int(speed.filter { "0"..."9" ~= $0 }) {
            return true
        } else {
            return false
        }
    }

    struct ButtonModifier: ViewModifier {
        var isActive: Bool

        func body(content: Content) -> some View {
            if self.isActive {
                return AnyView(content.padding().foregroundColor(.black).background(Color("themeColor")).clipShape(Circle()))
            } else {
                return AnyView(content.padding().foregroundColor(.white).overlay(
                    Circle().stroke(.white, lineWidth: 1)))
            }
        }
    }

    var body: some View {
        VStack(spacing: 30) {
            Button(action: {
                self.speedValue = Int(speed.filter { "0"..."9" ~= $0 }) ?? 0
            }) {
                Text(self.speed)
            }.modifier(ButtonModifier(isActive: self.isActive))
            VStack {
                Text(self.indexText)
                Text("Speed")
            }

        }.frame(maxWidth: .infinity).padding(20).overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 1)
        ).background(self.isActive ? Color("#454a57") : .clear).cornerRadius(16)
    }
}

struct SmallBoxView: View {
    let iconSrc: String
    let dataValue: Int
    let unit: String
    let subString: String

    var isActive: Bool {
        return self.dataValue != 0
    }

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: self.iconSrc)
            Text("\(self.dataValue)\(self.unit)").font(.title2).foregroundColor(.white).bold()
            Text(self.subString).foregroundColor(.white).font(.caption)
        }.frame(maxWidth: .infinity).padding().background(Color("lightBackgroundColor")).cornerRadius(12)
            .overlay(
                GeometryReader { geometry in
                    Divider()
                        .frame(width: geometry.size.width * 0.7, height: 1)
                        .background(self.isActive ? Color("themeColor") : Color.white)
                        .position(x: geometry.size.width / 2, y: geometry.size.height - 2)
                }
            )
    }
}

struct LongBox: View {
    var label: String
    var value: Int = 0
    var icon: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            HStack {
                Image(self.icon).scaledToFit().padding(.trailing, 10)
                VStack(alignment: .leading, spacing: 6) {
                    Text(self.label).lineLimit(1)
                    Text("\(self.value)W").bold().font(.title3)

                }.frame(minWidth: 0, maxWidth: .infinity)
            }
            Spacer()
            Toggle("", isOn: self.$isOn)
        }

        .padding(20)
        .background(Color("lightBackgroundColor"))
        .cornerRadius(12).padding(.bottom, 10)
    }
}

struct DeviceDetail_Previews: PreviewProvider {
    static var previews: some View {
        DeviceDetail(deviceSn: "sljladajf").preferredColorScheme(.dark).background(Color("backgroundColor"))
            .previewLayout(.sizeThatFits)
    }
}
