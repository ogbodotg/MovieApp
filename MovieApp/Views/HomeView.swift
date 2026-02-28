//
//  HomeView.swift
//  MovieApp
//
//  Created by OGBODO on 18/02/2026.
//

import SwiftUI

struct HomeView: View {
    let viewModel = ViewModel()
    @State private var detailView = NavigationPath()
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack (path: $detailView) {
            GeometryReader { geo in
                ScrollView {
                    switch viewModel.homeStatus{
                    case .notStarted:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                            .frame(width: geo.size.width, height: geo.size.height)
                    case .success:
                        LazyVStack{
                            AsyncImage(url: URL(string:viewModel.heroTitle.posterPath ?? "")){image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .overlay{
                                        LinearGradient(
                                            stops:[
                                                Gradient.Stop(color: .clear, location: 0.8),
                                                Gradient.Stop(color: .gradient, location: 1)
                                            ],
                                            startPoint: .top,
                                            endPoint: .bottom)
                                    }
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: geo.size.width, height: geo.size.height*0.85)
                            .onTapGesture{
                                detailView.append(viewModel.heroTitle)
                            }
                            
                            HStack(spacing: 14){
                                Button{
                                    detailView.append(viewModel.heroTitle)
                                }label:{
                                    Text(Constants.playString)
                                        .button()
                                }
                                
                                Button{
                                    modelContext.insert(viewModel.heroTitle)
                                    try? modelContext.save()
                                }label:{
                                    Text(Constants.downloadString)
                                        .button()
                                }
                            }
                            .padding(.horizontal)
                            
                            MovieList(header: Constants.trendingMoviesString, titles: viewModel.trendingMovies) {title in
                                detailView.append(title)
                            }
                            MovieList(header: Constants.trendingTVString, titles: viewModel.trendingTvShows) {title in
                                detailView.append(title)
                            }
                            MovieList(header: Constants.topRatedMovieString, titles: viewModel.topRatedMovies) {title in
                                detailView.append(title)
                            }
                            MovieList(header: Constants.topRatedTVString, titles: viewModel.topRatedTvShows) {title in
                                detailView.append(title)
                            }
                        }

                    case .failed(let error):
                        Text(error.localizedDescription)
                            .errorMessage()
                            .frame(width: geo.size.width, height: geo.size.height)
                    }
                    
                }
                .task{
                    await viewModel.getTitles()
                }
                .navigationDestination(for: Title.self) {
                    title in DetailsView(title: title)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
