//
//  ChatView.swift
//  Messenger
//
//  Created by Sebastian on 12/21/23.
//

import SwiftUI

struct ChatView: View {
    let chatPartner: User
    @StateObject private var viewModel: ChatViewModel

    init(chatPartner: User) {
        self._viewModel = StateObject(wrappedValue:
            ChatViewModel(chatPartner: chatPartner)
        )
        self.chatPartner = chatPartner
    }

    var body: some View {
        NavigationView {
            VStack {
                ScrollViewReader { scrollProxy in
                    ScrollView(.vertical) {
                        // chat partner profile information
                        VStack(spacing: 12) {
                            CircularProfileImageView(user: chatPartner, size: .xLarge)

                            VStack(spacing: 4) {
                                Text(chatPartner.fullName)
                                    .font(.title3)
                                    .fontWeight(.semibold)

                                Text("Messenger")
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding(.bottom)

                        // messages/conversation bubbles
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.messages) { message in
                                ChatMessageCell(message: message)
                                    .id(message.id) // assign each chat cell an id for scrolling
                            }
                            .onChange(of: viewModel.messages.last) { _, newLastMessage in
                                // Scroll to the end whenever messages are updated
                                withAnimation {
                                    scrollProxy.scrollTo(newLastMessage?.id, anchor: .bottom)
                                }
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
                .padding(.bottom, 8)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(chatPartner.fullName)
                    .font(.headline)
                    .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    NavigationView {
        ChatView(chatPartner: User.MOCK_USER)
    }
}
