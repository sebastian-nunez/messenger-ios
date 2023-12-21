//
//  ChatView.swift
//  Messenger
//
//  Created by Sebastian on 12/21/23.
//

import SwiftUI

struct ChatView: View {
    @State private var messageText = ""
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                // header
                VStack(spacing: 12) {
                    CircularProfileImageView(user: User.MOCK_USER, size: .xLarge)

                    VStack(spacing: 4) {
                        Text(User.MOCK_USER.fullName)
                            .font(.title3)
                            .fontWeight(.semibold)

                        Text("Messenger")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.bottom)

                // messages
                LazyVStack(spacing: 12) {
                    ForEach(1 ... 15, id: \.self) { _ in
                        ChatMessageCell(isFromCurrentUser: Bool.random())
                    }
                }
            }
        }

        Spacer()

        // message input view
        ZStack(alignment: .trailing) {
            TextField("Message...", text: $messageText, axis: .vertical)
                .font(.subheadline)
                .padding(16)
                .padding(.trailing, 48)
                .background(Color(.systemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 32))

            Button("Send") {
                print("DEBUG: sending message")
            }
            .fontWeight(.semibold)
            .padding(.trailing)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ChatView()
}
