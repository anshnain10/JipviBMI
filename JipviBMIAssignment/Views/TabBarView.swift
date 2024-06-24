//
//  TabBarView.swift
//  JipviBMIAssignment
//
//  Created by ANSH on 24/06/24.
//

import SwiftUI
import Firebase
import FirebaseDatabase

struct TabBarView: View {
    @ObservedObject var personalDetailsStore: PersonalDetailStore
//    @Binding var personalDetails: PersonalDetails
    var body: some View {
        TabView{
            ContentView().tabItem {
                Text("Home")
                Image(systemName: "house.fill")}
            GraphView().tabItem {
                            Text("Graph")
                            Image(systemName: "chart.bar.xaxis.ascending")
                        }
//
            SettingsView(personalDetailsStore: personalDetailsStore).tabItem {
                Text("Settings")
                Image(systemName: "gearshape.fill")}
            
            

        }
    }
   
}

#Preview {
    let store = PersonalDetailStore()
        return TabBarView(personalDetailsStore: store)
}
