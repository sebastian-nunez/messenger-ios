//
//  InboxView.swift
//  Messenger
//
//  Created by Sebastian on 12/16/23.
//

import SwiftUI

struct InboxView: View {
    @State private var showNewMessageView = false
    @StateObject private var viewModel = InboxViewModel()
    @State private var selectedUser: User?
    @State private var showChat = false

    private var user: User? {
        return viewModel.currentUser
    }

    private var recentMessages: [Message] {
        Array(viewModel.chatPartnerToRecentMessage.values)
            .sorted { $0.timestamp.dateValue() > $1.timestamp.dateValue() }
    }

    var body: some View {
        NavigationStack {
            List {
                ActiveNowView()
                    .listRowSeparator(.hidden) // hide the separator
                    .listRowInsets(EdgeInsets()) // move fully to the edges

                ForEach(recentMessages) { recentMessage in
                    // disables the "chevron" > (workaround to basically hide the NavLink)
                    ZStack {
                        NavigationLink(value: recentMessage) {
                            EmptyView()
                        }
                        .opacity(0.0)

                        InboxRowView(message: recentMessage)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .onChange(of: selectedUser) { _, newValue in // listen for changes of "selectedUser"
                showChat = newValue != nil
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .profile(let user): ProfileView(user: user)
                case .chatView(let chatPartner): ChatView(chatPartner: chatPartner)
                }
            }
            .navigationDestination(for: Message.self) { recentMessage in
                if let user = recentMessage.user {
                    ChatView(chatPartner: user)
                }
            }
            .navigationDestination(isPresented: $showChat) {
                if let user = selectedUser {
                    ChatView(chatPartner: user)
                }
            }
            .fullScreenCover(isPresented: $showNewMessageView) {
                NewMessageView(selectedUser: $selectedUser)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // LEFT
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 8) {
                        if let user = user {
                            NavigationLink(value: Route.profile(user)) {
                                // image
                                CircularProfileImageView(user: user)
                            }
                        }

                        // heading
                        Text("Chats")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                }

                // RIGHT
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewMessageView.toggle()

                        // reset the selected user
                        self.selectedUser = nil
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    }
                }
            }
        }
        .tint(.black)
    }
}

#Preview {
    InboxView()
}
