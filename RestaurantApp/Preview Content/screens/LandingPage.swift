//
//  LandingPage.swift
//  RestaurantApp
//
//  Created by KRISHNA on 17/07/25.
//

import SwiftUI

struct LandingPage: View {
    
    @StateObject var createAccountViewModel : CreateAccountViewModel = CreateAccountViewModel()
    @StateObject var loginViewModel = LoginViewModel()
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    @State private var isLoggedIn = false
    @State private var showErrorAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()
                
                VStack {
                    Image(systemName: "fork.knife.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.orange)
                    Text("Food App")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                
                VStack(spacing: 20) {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color(.systemGray))
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                NavigationLink(destination: AdminDashboardPage(dashboardViewModel: DashboardViewModel()), isActive: $isLoggedIn) {
                    EmptyView()
                }
                
                Button(action: {
                    loginViewModel.login(username: username, password: password) { success in
                        if success {
                            isLoggedIn = true
                        } else {
                            showErrorAlert = true
                        }
                    }
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .disabled(loginViewModel.isLoading)
                
                if loginViewModel.isLoading {
                    ProgressView()
                }
                
                
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    Text("or")
                        .foregroundColor(.gray)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                NavigationLink(destination: CreateAccountPage(createAccountViewModel: createAccountViewModel)) {
                    Text("Create New Account")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.orange)
                }
                
                Spacer()
            }
            .padding()
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text("Login Failed"),
                    message: Text(loginViewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            
        }
    }
}

#Preview {
    LandingPage()
}
