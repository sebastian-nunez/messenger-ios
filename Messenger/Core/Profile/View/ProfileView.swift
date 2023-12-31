//
//  ProfileView.swift
//  Messenger
//
//  Created by Sebastian on 12/21/23.
//

import PhotosUI
import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    var user: User

    var body: some View {
        VStack {
            // header
            VStack {
                PhotosPicker(selection: $viewModel.selectedItem) {
                    if let profileImage = viewModel.profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: ProfileImageSize.xxLarge.dimension, height: ProfileImageSize.xxLarge.dimension)
                            .clipShape(Circle())
                    } else {
                        CircularProfileImageView(user: user, size: .xxLarge)
                    }
                }

                Text(user.fullName)
                    .font(.title2)
                    .fontWeight(.semibold)
            }

            // list of settings
            List {
                Section {
                    ForEach(SettingsOptionsViewModel.allCases) { option in
                        HStack {
                            Image(systemName: option.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(option.imageBackgroundColor)

                            Text(option.title)
                                .font(.subheadline)
                        }
                    }
                }

                Section {
                    Button("Log Out") {
                        print("DEBUG: logging out")

                        AuthServiceImpl.shared.logout()
                    }
                    .tint(.red)

                    Button("Delete Account") {
                        print("DEBUG: deleting account")
                    }
                    .tint(.red)
                }
            }
        }
    }
}

#Preview {
    ProfileView(user: User.MOCK_USER)
}
