//
//  SignUpView.swift
//  Messenger
//
//  Created by Sebastian on 12/14/23.
//

import SwiftUI

struct SignUpView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
                
            // logo
            Image("MessengerLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding(.bottom, 32)
                
            // text fields
            VStack(spacing: 16) {
                TextField("Enter your full name", text: $fullName)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    
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
                
            // sign up button
            Button {
                print("Sign up")
            } label: {
                Text("Sign up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 45)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
            }
            .padding(.top)
            .padding(.horizontal)
                
            Spacer()
            Divider()
                
            // sign up link
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                        
                    Text("Log in")
                        .fontWeight(.semibold)
                }
                .font(.subheadline)
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    SignUpView()
}
