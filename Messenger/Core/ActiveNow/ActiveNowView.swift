//
//  ActiveNowView.swift
//  Messenger
//
//  Created by Sebastian on 12/16/23.
//

import SwiftUI

struct ActiveNowView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                // render users
                ForEach(0 ... 10, id: \.self) { _ in
                    VStack {
                        // image
                        ZStack(alignment: .bottomTrailing) {
                            CircularProfileImageView(user: User.MOCK_USER, size: .medium)

                            // green circle
                            ZStack {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 18, height: 18)

                                Circle()
                                    .fill(.green)
                                    .frame(width: 12, height: 12)
                            }
                        }

                        // name
                        Text("Bruce")
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
