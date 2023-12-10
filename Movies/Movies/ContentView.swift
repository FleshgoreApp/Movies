//
//  ContentView.swift
//  Movies
//
//  Created by Anton Shvets on 07.12.2023.
//

import SwiftUI

struct ContentView: View {
    let model = MoviesViewModel(
        networkManager: NetworkService(baseURL: NetworkConstant.baseURL)
    )
    
    var body: some View {
        MoviesView(viewModel: model)
    }
}

#Preview {
    ContentView()
}
