//
//  MoviesView.swift
//  Movies
//
//  Created by Anton Shvets on 07.12.2023.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject var viewModel: MoviesViewModel
    
    var body: some View {
        NavigationStack {
            list
                .listStyle(.inset)
                .scrollIndicators(.hidden)
                .refreshable {
                    viewModel.onRefresh()
                }
                .searchable(
                    text: $viewModel.filterText.value,
                    prompt: Text("Filter movies")
                )
                .navigationTitle("MOVIES")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    if viewModel.isLoading {
                        ToolbarItem(placement: .topBarTrailing) {
                            ProgressView()
                        }
                    }
                }
        }
    }
    
    private var list: some View {
        List {
            Group {
                if viewModel.searchFocused {
                    ForEach($viewModel.filteredMovies.value) { $movie in
                        simpleCell(movie)
                            .padding(.horizontal, 15)
                            .padding(.top, 12)
                    }
                } else {
                    ForEach(viewModel.categories.keys.sorted(), id: \.self) { key in
                        if let values = viewModel.categories[key],
                           !values.isEmpty {
                            CategoryRow(
                                categoryName: key,
                                items: values
                            )
                            .padding(.bottom, 20)
                        }
                    }
                }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
        }
    }
    
    private func simpleCell(_ movie: MovieEntity) -> some View {
        ZStack(alignment: .leading) {
            NavigationLink(destination: MovieDetailView(model: movie)) {
                EmptyView()
            }
            .opacity(0)
            .buttonStyle(.plain)
            
            SimpleCell(model: .init(movie: movie))
        }
    }
}

#Preview {
    NavigationStack {
        MoviesView(viewModel: MoviesViewModel(
            networkManager: NetworkService(baseURL: NetworkConstant.baseURL)
        ))
    }
}
