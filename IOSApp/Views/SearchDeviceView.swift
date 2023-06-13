//
//  AddDeviceView.swift
//  IOSApp
//
//  Created by 郭点 on 2023/6/9.
//

import SwiftUI


struct Device: Identifiable {
    let id = UUID()
    let name: String
    let type: String
}

let manuaDeviceListCodeable:[Device] = [
    Device(name:"Mango Power E",type: "mpe"),
    Device(name:"MPU Move",type: "mpu-move"),
    Device(name:"MPU Home",type: "mpu-home"),
    Device(name:"Mango Power M",type: "mpm"),
    
]

struct SearchDeviceView: View {
    var body: some View {
        ScrollView {
            BlueView()
            ManuaDeviceListView()
        }.padding()
    }
}

struct BlueView :View   {
    var body: some View{
        VStack() {
            HStack {
                Text("Bluetooth Devices").foregroundColor(.white).font(.title2)
                Spacer()
            }
            
            VStack(spacing: 20) {
                Image(systemName: "magnifyingglass").font(.system(size: 40))
                HStack {
                    Text("Scanning....").font(.title3)
                }
            }.padding()
        }
    }
}

struct ManuaDeviceListView: View {
    @State var showSheet = false
    var body: some View {
        VStack {
            HStack{
                Text("Add Device Manually").font(.title2)
                Spacer()
            }
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(manuaDeviceListCodeable){ device in
                    VStack {
                        Text(device.name)
                        Button(action:{
                            self.showSheet = true
                        }){
                            Image(device.type).resizable().scaledToFit()
                        }.sheet(isPresented: $showSheet){
                            BingSNView(deviceName:"Mango Power E" ,imgSrc: "mpe" ,showSheet: $showSheet)
                        }
                    }
                    
                }
            }
        }.padding(.top,50)
    }
}

struct  SearchDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        SearchDeviceView().preferredColorScheme(.dark)
    }
}
