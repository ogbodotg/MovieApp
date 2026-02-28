//
//  ComingSoonView.swift
//  MovieApp
//
//  Created by OGBODO on 19/02/2026.
//

import SwiftUI

struct ComingSoonView: View {
    let viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader {geo in
                switch viewModel.upcomingStatus {
                case .notStarted:
                    EmptyView()
                case .fetching:
                    ProgressView()
                        .frame(width: geo.size.width, height: geo.size.height)
                case .success:
                    VerticalListView(titles: viewModel.upComingMovies, allowDelete: false)
                case .failed(let underlyingError):
                    Text(underlyingError.localizedDescription)
                        .errorMessage()
                        .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            .task {
                await viewModel.getUpComingMovies()
            }
        }

    }
}

#Preview {
    ComingSoonView()
}
