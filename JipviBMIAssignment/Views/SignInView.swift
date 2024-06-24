//
//  SignInView.swift
//  JipviBMIAssignment
//
//  Created by ANSH on 25/06/24.
//

import SwiftUI
import Firebase

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isAuthenticated = false
    @State private var errorMessage = ""
    @State private var isActive = false
    @ObservedObject var personalDetailsStore: PersonalDetailStore
    var body: some View {
        NavigationStack{
            VStack{
                Spacer().frame(height: 40)
                            
                            Text("BMI Calculator")
                                .bold()
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .padding()
                                .shadow(radius: 10)
                                .padding(.bottom, 40)
                            
                            VStack(alignment: .leading, spacing: 20) {
                               
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Username *")
                                        .font(.headline)
                                    TextField("Enter your username", text: $email)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .strokeBorder(Color.gray, lineWidth: 1)
                                        )
                                }
                                
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Password *")
                                        .font(.headline)
                                    SecureField("Password", text: $password)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .strokeBorder(Color.gray, lineWidth: 1)
                                        )
                                }
                                
                               
                                HStack {
                                    Spacer()
                                    Button(action: {
                                       
                                    }) {
                                        Text("Forgot Password")
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                            .padding(.horizontal, 30)
                            
                            Spacer().frame(height: 40)
                            
                           
                            Button(action: {
                                signUp()
                            }) {VStack{
                                if !errorMessage.isEmpty{
                                    Text(errorMessage)
                                        .foregroundColor(.red)
                                        .padding()
                                }
                                Text("SIGN UP")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(30)
                            }
                                NavigationLink(value: isAuthenticated){
                                    EmptyView()
                                }
                                .navigationDestination(isPresented: $isAuthenticated){
                                    TabBarView(personalDetailsStore: personalDetailsStore)
                                       
                                }
                            }
                            .padding(.horizontal, 30)
            Spacer()
                Button(action: {
                    isActive = true
                }) {
                    HStack(alignment: .center,spacing: 5){
                        Text("Already have an account?").foregroundStyle(.black).font(.caption)
                        Text("Sign Up!").bold().foregroundStyle(.red).font(.caption)
                        
                    }
//
                    NavigationLink(value: isActive){
                        EmptyView()
                    }
                    .navigationDestination(isPresented: $isActive){
                        LoginView(personalDetailsStore: personalDetailsStore).navigationBarBackButtonHidden(true)
                           
                    }
    
                   
                }
                            
                        }
                        .background(Color.white.edgesIgnoringSafeArea(.all))
                    }
    }
    func signUp() {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    errorMessage = error.localizedDescription
                    print("Sign up failed: \(error.localizedDescription)")
                } else {
                    print("User signed up successfully!")
                    
                }
               
            }
        }
    func signOut() {
            do {
                try Auth.auth().signOut()
                self.isAuthenticated = false
                print("User signed out successfully!")
            } catch let signOutError as NSError {
                self.errorMessage = signOutError.localizedDescription
                print("Sign out failed: \(signOutError.localizedDescription)")
            }
        }
}

