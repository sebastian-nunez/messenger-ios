//
//  ActiveNowView.swift
//  Messenger
//
//  Created by Sebastian on 1/6/24.
//

import SwiftUI

struct ActiveNowView: View {
    @StateObject var viewModel = ActiveNowViewModel()

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                // render users
                ForEach(viewModel.users) { user in
                    VStack {
                        // image
                        ZStack(alignment: .bottomTrailing) {
                            CircularProfileImageView(user: user, size: .large)

                            // green circle
                            ZStack {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 18, height: 18)

                                Circle()
                                    .fill(.gray)
                                    .frame(width: 12, height: 12)
                            }
                        }

                        // name
                        Text(user.firstname)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
            }
            .padding(.horizontal)
        }
        // .scrollTargetBehavior(.paging)
        .frame(height: 106)
    }
}

#Preview {
    ActiveNowView()
}
