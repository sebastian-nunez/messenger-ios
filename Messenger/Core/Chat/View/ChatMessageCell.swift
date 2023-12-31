//
//  ChatMessageCell.swift
//  Messenger
//
//  Created by Sebastian on 12/21/23.
//

import SwiftUI

struct ChatMessageCell: View {
    let message: Message

    private var isFromCurrentUser: Bool {
        message.isFromCurrentUser
    }

    private let SENT_MESSAGE_WIDTH = UIScreen.main.bounds.width * (2.0 / 3.0)
    private let RECEIVED_MESSAGE_WIDTH = UIScreen.main.bounds.width * (3.0 / 5.0)

    var body: some View {
        HStack {
            // place to the right and blue
            if isFromCurrentUser {
                Spacer()

                Text(message.messageText)
                    .font(.subheadline)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(.black)
                    .foregroundStyle(.white)
                    .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: SENT_MESSAGE_WIDTH, alignment: .trailing)

            } else { // place to the left and grey with image
                HStack(alignment: .bottom, spacing: 8) {
                    CircularProfileImageView(user: message.user, size: .xxSmall)

                    Text(message.messageText)
                        .font(.subheadline)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(Color(.systemGray5))
                        .foregroundStyle(.black)
                        .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                        .frame(maxWidth: RECEIVED_MESSAGE_WIDTH, alignment: .leading)
                }

                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ChatMessageCell(message: Message.MOCK_MESSAGE)
}
