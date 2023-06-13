//
//  Setting.swift
//  IOSApp
//
//  Created by 郭点 on 2023/6/7.
//

import SwiftUI
enum BadgeStatus {
    case success
    case error
    case normal
    case warning
}

struct Setting: View {
    @State var timezone = 0
    @StateObject var deviceSetting = DeviceSetting()

    var body: some View {
        List {
            Section(header: Text("Device Info")) {
                VStack(spacing: 20) {
                    NavigationLink(destination: EditNameView( initialName: deviceSetting.deviceName, editName: deviceSetting.editDeviceName)) {
                        HStack {
                            Text("Device Name").foregroundColor(.white).bold()
                            Spacer()
                            Text(deviceSetting.deviceName).foregroundColor(.white).bold()
                        }
                    }.padding(20)

                    HStack {
                        Text("Device SN").foregroundColor(.white).bold()
                        Spacer()
                        Text(deviceSetting.deviceSn).foregroundColor(.white).bold()
                    }.padding(20).padding(.vertical, 8)

                    HStack {
                        Text("Device Modal").foregroundColor(.white).bold()
                        Spacer()
                        Text(deviceSetting.displayName).foregroundColor(.white).bold()
                    }.padding(20).padding(.vertical, 8)

                }.listRowInsets(EdgeInsets()).background(Color("backgroundColor"))
            }

            Section(header: Text("Setting")) {
                VStack(spacing: 20) {
                    NavigationLink(destination: DetailView()) {
                        HStack {
                            Text("Wi-Fi").foregroundColor(.white).bold()
                            Spacer()
                        }
                    }.padding(20)

                    HStack {
                        Text("Bluetooth").foregroundColor(.white).bold()
                        Spacer()
                        Text("111").foregroundColor(.white).bold()
                    }.padding(20).padding(.vertical, 8)

                    HStack {
                        Text("Timezone").foregroundColor(.white).bold()
                        Spacer()
                        Picker("", selection: $timezone) {
                            ForEach(-12 ..< 12, id: \.self) { number in
                                if number >= 0 {
                                    Text("UTC+\(number)").foregroundColor(.white)
                                } else {
                                    Text("UTC\(number)").foregroundColor(.white)
                                }
                            }
                        }.pickerStyle(.menu)
                    }.padding(20).padding(.vertical, 8)

                }.listRowInsets(EdgeInsets()).background(Color("backgroundColor"))
            }

            Section(header: Text("Others")) {
                VStack(spacing: 20) {
                    NavigationLink(destination: FirmwareView()) {
                        HStack {
                            Text("Firmware").foregroundColor(.white).bold()
                            Spacer()
                            BadgeView(status: .warning)
                        }
                    }.padding(20)
                }.listRowInsets(EdgeInsets()).background(Color("backgroundColor"))
            }
        }
    }
}

struct BadgeView: View {
    var status: BadgeStatus = .normal

    private var badgeColor: Color {
        switch status {
        case .normal:
            return Color.gray
        case .success:
            return Color.green
        case .error:
            return Color.red
        case .warning:
            return Color.yellow
        }
    }

    var body: some View {
        Circle().fill(badgeColor).frame(width: 8, height: 8)
    }
}

struct NoPadding: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowInsets(EdgeInsets(top: 0, leading: 30, bottom: 30, trailing: 0))
    }
}

struct DetailView: View {
    var body: some View {
        Text("详情页面")
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting().preferredColorScheme(.dark).background(Color("backgroundColor"))
            .previewLayout(.sizeThatFits)
    }
}
