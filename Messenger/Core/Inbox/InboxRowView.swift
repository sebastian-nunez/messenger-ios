//
//  InboxRowView.swift
//  Messenger
//
//  Created by Sebastian on 12/16/23.
//

import SwiftUI

struct InboxRowView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // image
            CircularProfileImageView(user: User.MOCK_USER, size: .large)

            // user info
            VStack(alignment: .leading, spacing: 8) {
                // name
                Text("Bruce Wayne")
                    .font(.headline)
                    .fontWeight(.semibold)

                // message
                Text("Some message for now that spans more than 1 line")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }

            Spacer()

            HStack {
                // date
                Text("Yesterday")

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
    InboxRowView()
}
