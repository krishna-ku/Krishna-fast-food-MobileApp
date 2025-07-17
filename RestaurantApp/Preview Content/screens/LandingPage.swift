//
//  LandingPage.swift
//  RestaurantApp
//
//  Created by KRISHNA on 17/07/25.
//

import SwiftUI

struct LandingPage: View {
    
    @StateObject var createAccountViewModel : CreateAccountViewModel = CreateAccountViewModel()
    
    @State private var userId: String = ""
    @State private var password: String = ""

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
                    Text("Krishna Fast Food")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                
                VStack(spacing: 20) {
                    TextField("Username", text: $userId)
                        .padding()
                        .background(Color(.systemGray))
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Button(action: {
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
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
        }
    }
}

#Preview {
    LandingPage()
}
