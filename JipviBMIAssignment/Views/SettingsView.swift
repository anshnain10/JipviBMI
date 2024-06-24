//
//  SettingsView.swift
//  JipviBMIAssignment
//
//  Created by ANSH on 23/06/24.
//

import SwiftUI

struct SettingsView: View {
//    @Binding var personalDetails: PersonalDetails
        @ObservedObject var personalDetailsStore: PersonalDetailStore
    @State var isEditing = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationStack{
            ScrollView{
                Spacer().frame(height: 100)
                VStack(alignment: .center,spacing: 20){
                    Button(action: {
                        isEditing = true
                        
                    }) {
                        Text("Edit Personal Details")
                            .font(.headline)
                            .bold()
                            .frame(maxWidth: 200)
                            .foregroundStyle(.white)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 25.0).stroke(.black,lineWidth: 3.0).fill(.red))
                        NavigationLink(destination: ContentView(), isActive: $isEditing) {
                            EmptyView()
                        }
                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    Button(action: {
                        Task{
                            do{
                                try await AuthenticationView().logout()
                                SignInView(personalDetailsStore: personalDetailsStore).signOut()
                            } catch let e {
                                
                                let err=e.localizedDescription
                            }
                        }
                        
                    }) {
                        Text("Sign Out")
                            .font(.headline)
                            .bold()
                            .frame(maxWidth: 200)
                            .foregroundStyle(.white)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 25.0).stroke(.black,lineWidth: 3.0).fill(.red))
                        
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                }.navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.automatic)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarBackground(.red, for: .navigationBar)
            }
        }
    }
}


