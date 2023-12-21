//
//  ProfileViewModel.swift
//  Messenger
//
//  Created by Sebastian on 12/21/23.
//

import Foundation
import PhotosUI
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task {
                try await loadImage()
            }
        }
    }

    @Published var profileImage: Image?

    func loadImage() async throws {
        // ensure we have a selectedItem
        guard let item = selectedItem else {
            print("DEBUG: no selected item, unable to load image")
            return
        }

        // convert selectedItem into a "Data" type
        guard let imageData = try await item.loadTransferable(type: Data.self) else {
            print("DEBUG: unable to load image data")
            return
        }

        // create a UIImage from the "data"
        guard let uiImage = UIImage(data: imageData) else {
            print("DEBUG: unable to create UIImage")
            return
        }

        profileImage = Image(uiImage: uiImage)
    }
}
