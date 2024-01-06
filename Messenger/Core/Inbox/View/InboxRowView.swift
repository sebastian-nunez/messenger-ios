//
//  InboxRowView.swift
//  Messenger
//
//  Created by Sebastian on 12/16/23.
//

import SwiftUI

struct InboxRowView: View {
    var message: Message

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // image
            CircularProfileImageView(user: message.user, size: .large)

            // user info
            VStack(alignment: .leading, spacing: 8) {
                // name
                Text(message.user?.fullName ?? "NO NAME")
                    .font(.headline)
                    .fontWeight(.semibold)

                // message
                Text(message.messageText)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }

            Spacer()

            HStack {
                // date
                Text(message.timestampString)

                // indicator
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
            }
            .font(.footnote)
            .foregroundStyle(.gray)
        }
        .frame(height: 72)
    }
}

#Preview {
    InboxRowView(message: Message.MOCK_MESSAGE)
}
