//
//  InitialView.swift
//  JipviBMIAssignment
//
//  Created by ANSH on 24/06/24.
//

import SwiftUI
import Firebase

struct InitialView: View {
    @State private var userLoggedIn = (Auth.auth().currentUser != nil)
    @ObservedObject var personalDetailsStore: PersonalDetailStore
    
    var body: some View {
        VStack{
            if userLoggedIn{
                TabBarView(personalDetailsStore: personalDetailsStore)
            } else {
                LoginView(personalDetailsStore: personalDetailsStore)
            }
            
            
        }.onAppear{
            
            Auth.auth().addStateDidChangeListener{auth, user in
            
                if (user != nil) {
                    
                    userLoggedIn = true
                } else{
                    userLoggedIn = false
                }
            }
        }
    }
}
