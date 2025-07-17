//
//  CreateAccountPage.swift
//  RestaurantApp
//
//  Created by KRISHNA on 17/07/25.
//


import SwiftUI

struct CreateAccountPage: View {
    
    @ObservedObject var createAccountViewModel : CreateAccountViewModel
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var role: String = "USER"
    
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 25) {
            
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            Group {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                SecureField("Password", text: $password)
                TextField("Role", text: $role)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .textInputAutocapitalization(.never)
            .padding(.horizontal)
            
            
            Button("Create Account") {
                createAccountViewModel.createUser(
                    firstName: firstName,
                    lastName: lastName,
                    email: email,
                    password: password,
                    role: role
                )
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            if createAccountViewModel.isLoading {
                ProgressView()
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Message"),
                message: Text(createAccountViewModel.message),
                dismissButton: .default(Text("OK")) {
                    if createAccountViewModel.message == "User created successfully!" {
                        firstName = ""
                        lastName = ""
                        email = ""
                        password = ""
                    }
                }
            )
        }
        .onChange(of: createAccountViewModel.message) {
            showAlert = true
        }
    }
}

#Preview {
    CreateAccountPage(createAccountViewModel: CreateAccountViewModel())
}
