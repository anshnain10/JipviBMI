//
//  LoginView.swift
//  JipviBMIAssignment
//
//  Created by ANSH on 24/06/24.
//

import SwiftUI
import Firebase
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var loginError = ""
    @State private var isLoggedIn = false
    @State private var isActive = false
    @State private var vm = AuthenticationView()
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
                                login()
                            }) {
                                VStack{
                                if !loginError.isEmpty{
                                    Text(loginError)
                                        .foregroundColor(.red)
                                        .padding()
                                }
                                Text("Login")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(30)
                            }
                                NavigationLink(value: isLoggedIn){
                                    EmptyView()
                                }
                                .navigationDestination(isPresented: $isLoggedIn){
                                    TabBarView(personalDetailsStore: personalDetailsStore)
                                        .navigationBarBackButtonHidden(true)
                                }
                            }
                            .padding(.horizontal, 30)
                
                            Button(action: {
                                vm.signInWithGoogle()
                            }) {
                                HStack(alignment: .center,spacing: 5)
                                {Image(systemName: "envelope.fill")
                                Text("Login with Google")}
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(30)
                                
                
                                NavigationLink(value: isLoggedIn){
                                    EmptyView()
                                }
                                .navigationDestination(isPresented: $isLoggedIn){
                                    TabBarView(personalDetailsStore: personalDetailsStore)
                                        .navigationBarBackButtonHidden(true)
                                }
                            }
                            .padding(.horizontal, 30)
                            .padding(.top, 10)
                Spacer()
                Button(action: {
                    isActive = true
                }) {
                    HStack(alignment: .center,spacing: 5){
                        Text("Don't have an account?").foregroundStyle(.black).font(.caption)
                        Text("Register now!").bold().foregroundStyle(.red).font(.caption)
                        
                    }
//
                    NavigationLink(value: isActive){
                        EmptyView()
                    }
                    .navigationDestination(isPresented: $isActive){
                        SignInView(personalDetailsStore: personalDetailsStore).navigationBarBackButtonHidden(true)
                           
                    }
    
                   
                }
                                
                            
                        }
                        .background(Color.white.edgesIgnoringSafeArea(.all))
                    }
                }
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
        
            if let error = error {
                loginError = error.localizedDescription
            }
            
            isLoggedIn = true
        }
    }
}

