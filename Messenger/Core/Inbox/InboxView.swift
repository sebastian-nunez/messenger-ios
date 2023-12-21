//
//  InboxView.swift
//  Messenger
//
//  Created by Sebastian on 12/16/23.
//

import SwiftUI

struct InboxView: View {
    @State private var showNewMessageView = false
    @State private var user = User.MOCK_USER

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                ActiveNowView()

                List {
                    ForEach(1 ... 30, id: \.self) { _ in
                        InboxRowView()
                    }
                }
                .listStyle(PlainListStyle())
                .frame(height: UIScreen.main.bounds.height - 120)
            }
            .navigationDestination(for: User.self) { user in
                ProfileView(user: user)
            }
            .fullScreenCover(isPresented: $showNewMessageView) {
                NewMessageView()
            }
            .toolbar {
                // LEFT
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 16) {
                        NavigationLink(value: user) {
                            // image
                            if let imageUrl = user.profileImageUrl {
                                Image(imageUrl)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 32, height: 32)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(Color(.systemGray4))
                            }
                        }

                        // heading
                        Text("Chats")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }

                // RIGHT
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewMessageView.toggle()
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
