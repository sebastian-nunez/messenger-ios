//
//  LoginView.swift
//  Messenger
//
//  Created by Sebastian on 12/14/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // logo
                Image("MessengerLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 32)
                    
                // text fields
                VStack(spacing: 16) {
                    TextField("Enter your email", text: $email)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    SecureField("Enter your password", text: $password)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                .font(.subheadline)
                .padding(.horizontal)
                
                // forgot password
                Button {
                    print("Forgot password")
                } label: {
                    Text("Forgot password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
                
                // login button
                Button {
                    print("Login")
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, minHeight: 45)
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                }
                .padding(.top)
                .padding(.horizontal)
                
                // divider
                HStack {
                    Rectangle()
                        .frame(height: 0.3)
                    
                    Text("OR")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Rectangle()
                        .frame(height: 0.3)
                }
                .foregroundStyle(.gray)
                .padding()
                
                // facebook login
                Button {
                    print("Login with Facebook")
                } label: {
                    HStack {
                        Image("FacebookLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text("Continue with Facebook")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.systemBlue))
                    }
                }
                
                Spacer()
                Divider()
                
                // sign up link
                NavigationLink {
                    Text("Sign up")
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                            
                        Text("Sign up")
                            .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                }
                .padding(.vertical)
            }
        }
    }
}

#Preview {
    LoginView()
}
