//
//  TrendingMovies.swift
//  MovieApp
//
//  Created by OGBODO on 18/02/2026.
//

import SwiftUI

struct MovieList: View {
     let header: String
    let titles: [Title]
    let onSelect: (Title) -> Void
    
    var body: some View {
        VStack( alignment: .leading){
            Text(header)
                .font(.title2)
            
            ScrollView(.horizontal){
                LazyHStack(spacing: 6){
                    ForEach(titles){title in
                        AsyncImage(url: URL(string: title.posterPath ?? "", )){image in
                            image
                                .resizable()
                                .scaledToFill()
                                
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120, height: 200)
                        .shadow(radius: 3)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .onTapGesture {
                            onSelect(title)
                        }

                    }
                }
            }
            
           
        }
        .frame(height: 250)
        .padding(10)
    }
}

#Preview {
    MovieList(header: Constants.trendingMoviesString, titles: Title.previewTitles, ){title in
        
    }
}
