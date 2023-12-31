//
//  ChatView.swift
//  Messenger
//
//  Created by Sebastian on 12/21/23.
//

import SwiftUI

struct ChatView: View {
    let user: User
    @StateObject private var viewModel: ChatViewModel

    init(user: User) {
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
        self.user = user
    }

    var body: some View {
        VStack {
            ScrollView(.vertical) {
                // header
                VStack(spacing: 12) {
                    CircularProfileImageView(user: user, size: .xLarge)

                    VStack(spacing: 4) {
                        Text(user.fullName)
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
            TextField("Message...", text: $viewModel.messageText, axis: .vertical)
                .font(.subheadline)
                .padding(16)
                .padding(.trailing, 48)
                .background(Color(.systemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 32))

            Button("Send") {
                viewModel.sendMessage()

                // reset the text field
                viewModel.messageText = ""
            }
            .fontWeight(.semibold)
            .padding(.trailing)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ChatView(user: User.MOCK_USER)
}
