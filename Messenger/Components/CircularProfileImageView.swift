//
//  CircularProfileImageView.swift
//  Messenger
//
//  Created by Sebastian on 12/21/23.
//

import SwiftUI

enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    case xxLarge

    var dimension: Double {
        switch self {
        case .xxSmall: 28
        case .xSmall: 32
        case .small: 40
        case .medium: 56
        case .large: 64
        case .xLarge: 80
        case .xxLarge: 120
        }
    }
}

struct CircularProfileImageView: View {
    var user: User?
    var size: ProfileImageSize = .xSmall

    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            Image(imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .foregroundStyle(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularProfileImageView(user: User.MOCK_USER)
}
