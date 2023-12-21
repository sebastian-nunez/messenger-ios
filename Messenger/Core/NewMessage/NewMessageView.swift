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
                    ForEach(1 ... 10, id: \.self) { _ in
                        VStack {
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(Color(.systemGray4))

                                Text("Chadwick Bozeman")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)

                                Spacer()
                            }
                            .padding(.leading)

                            Divider()
                                .padding(.leading, 56)
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
        NewMessageView()
    }
}
