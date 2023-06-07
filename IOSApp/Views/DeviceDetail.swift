//
//  DeviceDetail.swift
//  IOSApp
//
//  Created by 郭点 on 2023/6/3.
//

import SwiftUI
import SwiftyJSON

let jsonString = """
{"status":0,"message":"ok","timestamp":"2023-06-05T02:20:38.453Z","data":{"id":"cd391bfc-0d4b-4407-a2c7-928a5808536a","createdAt":"2023-05-06T02:36:41.471974Z","deviceId":"e0b84798-9856-404e-be24-c38aabbfb53b","shadow":{"id":"e0b84798-9856-404e-be24-c38aabbfb53b","sn":"100202YA2B000023","state":{"emsSetting":{"boot":true,"reset":false,"sysTime":{"day":18,"hour":21,"year":22,"month":10,"minute":50,"second":21},"timerMode":false,"upsEnable":false,"timeSlices":[{"endHour":0,"endMinute":0,"startHour":0,"startMinute":0}],"chargeEnable":true,"acOutputEnable":false,"dcOutputEnable":false,"ecoReservedSoc":0,"maxChargeCurrent":15,"upsAutoChargeSoc":85,"discharge240Enable":false},"pcsSetting":{"acFrequency":60,"acOutputVolt":120},"realtimeData":{"bmsData":[{"soc":0,"temp":265,"volt":44040,"state":192,"current":0,"warning":[1,10,12],"capacity":6700}],"emsData":{"error":0,"dcPower":0,"powerPv":0,"socReal":0,"socUser":0,"warning":0,"sysState":1,"powerGrid":0,"powerLoad":0,"workState":0,"parallelInfo":{"id":0,"soc":0,"powerPv":0,"powerGrid":0,"powerLoad":0}},"pcsData":{"acVolt":5,"dcVolt":4379,"acPower":0,"acCurrent":0,"dcCurrent":66,"errorInfo":[14,28],"inletAirTemp":266,"outletAirTemp":301},"mpptData":{"inputVolt":43,"inputPower":0,"inputTotal":0,"inputCurrent":43},"collector":{"grid":{"input":{"power":0,"kwhToday":{"low":0,"high":0,"unsigned":false},"kwhTotal":{"low":0,"high":0,"unsigned":false},"kwhPeriod":{"low":0,"high":0,"unsigned":false}},"total":{"power":0,"kwhToday":{"low":0,"high":0,"unsigned":false},"kwhTotal":{"low":0,"high":0,"unsigned":false},"kwhPeriod":{"low":0,"high":0,"unsigned":false}},"output":{"power":0,"kwhToday":{"low":0,"high":0,"unsigned":false},"kwhTotal":{"low":0,"high":0,"unsigned":false},"kwhPeriod":{"low":0,"high":0,"unsigned":false}}},"load":{"power":0,"kwhToday":{"low":0,"high":0,"unsigned":false},"kwhTotal":{"low":0,"high":0,"unsigned":false},"kwhPeriod":{"low":0,"high":0,"unsigned":false}},"solar":{"volt":43,"power":0,"current":-430,"kwhToday":{"low":0,"high":0,"unsigned":false},"kwhTotal":{"low":0,"high":0,"unsigned":false},"kwhPeriod":{"low":0,"high":0,"unsigned":false}},"battery":{"soc":0,"soh":0,"input":{"power":0,"kwhToday":{"low":0,"high":0,"unsigned":false},"kwhTotal":{"low":0,"high":0,"unsigned":false},"kwhPeriod":{"low":0,"high":0,"unsigned":false}},"total":{"power":0,"kwhToday":{"low":0,"high":0,"unsigned":false},"kwhTotal":{"low":0,"high":0,"unsigned":false},"kwhPeriod":{"low":0,"high":0,"unsigned":false}},"output":{"volt":440,"power":0,"current":0,"kwhToday":{"low":0,"high":0,"unsigned":false},"kwhTotal":{"low":0,"high":0,"unsigned":false},"kwhPeriod":{"low":0,"high":0,"unsigned":false}},"capacity":6700}}}},"version":1,"collectorSn":"800800ZA2B100011"},"updateAt":"2023-05-26T08:01:13.836Z","remark":null},"minVersion":"2.4.0"}
"""

let realDataJSON = """
{"status":0,"message":"ok","timestamp":"2023-06-05T03:28:20.129Z","data":{"id":"e0b84798-9856-404e-be24-c38aabbfb53b","createdAt":"2023-04-26T10:26:32.492108Z","sn":"100202YA2B000023","name":"hdhdheujdbskkdnjdj23","userId":null,"remark":"mpe","supplier":"MP","collectorSn":"800800ZA2B100011","protocolNumber":null,"hardwareVersion":"1.3.3","firmwareVersion":"4.2.1","targetFirmwareVersion":null,"targetFirmwareId":null,"modelId":null,"timezone":8,"modelData":{"id":"7abb2260-3970-4e3b-93a9-fac51e99bdb4","createdAt":"2022-12-13T10:03:55.401444Z","name":"mpe","displayName":"Mango Power E","activeFirmwareId":"bda9e3d9-0265-4f41-a3bb-2c95beffb516","remark":"MPE 自研 美版","region":"US","collectorModelId":"5a303243-4005-4903-9bdd-79fc1ffe8ef9","collection":"mpe"},"mpuMap":null,"collector":{"id":"0232cf6c-e2df-4f62-b7fd-22f4d5872308","createdAt":"2022-10-22T12:33:57.598796Z","sn":"800800ZA2B100011","model":null,"remark":null,"status":2,"firmwareVersion":"1.1.9","macAddress":"58:CF:79:14:B4:64","lastOnlineAt":"2023-05-26T08:00:56.639Z","lastOfflineAt":"2023-05-26T08:03:28.824Z","offlineReason":"Abnormal offline","lastActiveAt":"2023-05-26T08:01:13.841Z","targetFirmwareId":null,"targetFirmwareUpdateForce":false,"iotPlatform":"aws","modelId":"5a303243-4005-4903-9bdd-79fc1ffe8ef9"},"data":{"id":"309daeec-a20b-4317-b681-a265adfedad1","createdAt":"2023-05-26T08:01:13.839141Z","timestamp":"2023-05-26T08:01:13.839Z","deviceId":null,"batterySoc":0,"batterySoh":0,"batteryCapacity":6700,"batteryInW":0,"batteryOutW":0,"inputTotal":0,"outputTotal":2,"acOutputTotal":0,"dcOutputTotal":0,"temperature":26,"gridInW":0,"gridOutW":0}},"minVersion":"2.4.0"}
"""
let speedListMap: [String: [String]] = [
    "MPUUS": ["10A", "15A", "20A"],
    "MPUEU": ["10A", "15A", "20A"],
    "MPEUS": ["10A", "15A", "30A"],
    "MPEEU": ["5A", "10A", "15A"]
]
class DeviceSetting: ObservableObject {
    @Published var chargeEnable = false
    @Published var acOutputEnable = false
    @Published var dcOutputTotal = false

    func fetchData() async {
        let json = JSON(parseJSON: jsonString)
        let status = json["data"].intValue
        guard status == 0 else {
            print("error")
            return
        }
        let dataJSON = json["data"]
        self.chargeEnable = dataJSON["shadow"]["state"]["emsSetting"]["chargeEnable"].boolValue
        self.acOutputEnable = dataJSON["shadow"]["state"]["emsSetting"]["acOutputEnable"].boolValue
        self.dcOutputTotal = dataJSON["shadow"]["state"]["emsSetting"]["dcOutputTotal"].boolValue
    }

    init() {
        Task {
            await self.fetchData()
        }
    }
}

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
        self.inputTotal = dataJSON["data"]["inputTotal"].intValue
        self.outputTotla = dataJSON["data"]["outputTotal"].intValue
        self.temperature = dataJSON["data"]["temperature"].intValue
    }

    init() {
        Task {
            await self.fetchData()
        }
    }
}

struct DeviceDetail: View {
    let deviceSn: String
    let deivceImage: String = "mpe"
    @State var dataJSON = JSON()
    @StateObject var deviceSetting = DeviceSetting()
    @StateObject var realTimeDataInfo = RealTimeDataInfo()
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    @State var deviceInfo = JSON()

    var body: some View {
        NavigationView {
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

                SpeedBox()
            }.padding(8)
        }
    }
}

struct SpeedBox: View {
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack {
            HStack{
                HStack{
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
                SpeedBoxRation()
                SpeedBoxRation()
                SpeedBoxRation()
            }.padding(.vertical,20)
          
        } .padding(20)
            .background(Color("lightBackgroundColor"))
            .cornerRadius(12).padding(.bottom, 10)
            
    }
}

struct SpeedBoxRation: View {
    var isActive = false
    struct ButtonModifier: ViewModifier {
            var isActive: Bool

            func body(content: Content) -> some View {
                if isActive {
                    return AnyView(content.padding().foregroundColor(.black).background(Color("themeColor")).clipShape(Circle()))
                } else {
                    return AnyView(content.padding().foregroundColor(.white).overlay(
                        Circle().stroke(.white, lineWidth: 1)))
                }
            }
        }
    var body: some View {
        VStack(spacing: 30){
            Button(action:{}){
                Text("10A")
            }.modifier(ButtonModifier(isActive: isActive))
            VStack {
                Text("Low")
                Text("Speed")
            }

            
        }.frame(maxWidth: .infinity).padding(20).overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 1)
        ).background( isActive ? Color("#454a57") : .clear)
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
        DeviceDetail(deviceSn: "sljladajf").preferredColorScheme(.dark).background(Color("backgroundColor")).ignoresSafeArea()
            .previewLayout(.sizeThatFits)
    }
}
