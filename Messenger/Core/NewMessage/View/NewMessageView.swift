//
//  NewMessageView.swift
//  Messenger
//
//  Created by Sebastian on 12/21/23.
//

import SwiftUI

struct NewMessageView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var searchText = ""
    @StateObject var viewModel = NewMessageViewModel()

    @Binding var selectedUser: User?

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                // search field
                TextField("To: ", text: $searchText)
                    .frame(height: 45)
                    .padding(.leading)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .padding(.horizontal)
                    .padding(.top, 8)

                // contact list
                Text("CONTACTS")
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()

                LazyVStack(spacing: 16) {
                    ForEach(viewModel.users) { user in
                        VStack {
                            HStack {
                                CircularProfileImageView(user: user, size: .small)

                                Text(user.fullName)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)

                                Spacer()
                            }
                            .padding(.leading)

                            Divider()
                                .padding(.leading, 56)
                        }
                        .onTapGesture {
                            // update selected user on tap
                            selectedUser = user
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .tint(.black)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        NewMessageView(selectedUser: .constant(User.MOCK_USER))
    }
}
