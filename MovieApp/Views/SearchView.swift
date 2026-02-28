//
//  SearchView.swift
//  MovieApp
//
//  Created by OGBODO on 19/02/2026.
//

import SwiftUI

struct SearchView: View {
    @State private var searchByMovies = true
    @State private var searchText = ""
    private let searchViewModel = SearchViewModel()
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView{
                if let error = searchViewModel.errorMessage {
                     Text(error)
                        .errorMessage()
                    

                }
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]){
                    ForEach(searchViewModel.searchTitles) { title in
                        AsyncImage(url: URL(string: title.posterPath ?? "")){image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: 10))
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120, height: 200)
                        .onTapGesture{
                            navigationPath.append(title)
                        }
                    }
                }
            }
            .navigationTitle(searchByMovies ? Constants.movieSearchString : Constants.tvSearchString)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        searchByMovies.toggle()
                        
                        Task {
                            await searchViewModel.getSearchTitles(by: searchByMovies ? .movie : .tv, for: searchText)
                        }
                    } label: {
                        Image(systemName: searchByMovies ? Constants.movieIconString : Constants.tvIconString)
                    }
                }
                
            }
            .searchable(text: $searchText, prompt: searchByMovies ? Constants.movieSearchHint : Constants.tvSearchHint)
            .task(id: searchText){
                try? await Task.sleep(for: .milliseconds(500))
                
                if Task.isCancelled{
                    return
                }
                
                await searchViewModel.getSearchTitles(by: searchByMovies ? .movie : .tv, for: searchText)
                
            }
            .navigationDestination(for: Title.self){title in
                DetailsView(title: title)
            }
        }
    }
}

#Preview {
    SearchView()
}
