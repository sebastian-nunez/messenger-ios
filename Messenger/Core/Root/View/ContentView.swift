//
//  ContentView.swift
//  Messenger
//
//  Created by Sebastian on 12/14/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
            } else {
                InboxView()
            }
        }
    }
}

#Preview {
    ContentView()
}
