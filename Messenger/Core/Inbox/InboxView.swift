//
//  InboxView.swift
//  Messenger
//
//  Created by Sebastian on 12/16/23.
//

import SwiftUI

struct InboxView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                ActiveNowView()
            }
            .toolbar {
                // LEFT
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 16) {
                        // image
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 32, height: 32)

                        // heading
                        Text("Chats")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }

                // RIGHT
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("show new message view")
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
    }
}

#Preview {
    InboxView()
}
