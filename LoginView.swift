//
//  LoginView.swift
//  Messenger
//
//  Created by Sebastian on 12/14/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                // logo
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.bottom, 32)

                // text fields
                VStack(spacing: 16) {
                    TextField("Enter your email", text: $viewModel.email)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                    SecureField("Enter your password", text: $viewModel.password)
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

                .padding(.top, -8)

                // login button
                Button {
                    Task {
                        try await viewModel.login()
                    }
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, minHeight: 45)
                        .background(.black)
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

                // apple login
                Button {
                    print("Login with Apple")
                } label: {
                    HStack {
                        Image("AppleLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 20)

                        Text("Continue with Apple")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                    }
                }

                Spacer()
                Divider()

                // sign up link
                NavigationLink {
                    SignUpView()
                        .navigationBarBackButtonHidden()
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
        .tint(.black)
    }
}

#Preview {
    LoginView()
}
