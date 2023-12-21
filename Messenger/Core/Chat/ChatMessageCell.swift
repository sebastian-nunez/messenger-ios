//
//  ChatMessageCell.swift
//  Messenger
//
//  Created by Sebastian on 12/21/23.
//

import SwiftUI

struct ChatMessageCell: View {
    let isFromCurrentUser: Bool

    var body: some View {
        HStack {
            // place to the right and blue
            if isFromCurrentUser {
                Spacer()

                Text("This is a very long test message for now. It expands multiple lines.")
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemBlue))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

            } else { // place to the left and grey with image
                HStack(alignment: .bottom, spacing: 8) {
                    CircularProfileImageView(user: User.MOCK_USER, size: .xxSmall)

                    Text("This is a very long test message for now. It expands multiple lines.")
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .foregroundStyle(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                Spacer()
            }
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    ChatMessageCell(isFromCurrentUser: false)
}
