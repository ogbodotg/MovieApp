//
//  Constants.swift
//  MovieApp
//
//  Created by OGBODO on 18/02/2026.
//

import Foundation
import SwiftUI

struct Constants{
    static let homeString = "Home"
    static let comingSoonMoviesString = "Coming Soon"
    static let searchString = "Search"
    static let downloadString = "Download"
    static let playString = "Play"
    static let trendingMoviesString = "Trending Movies"
    static let trendingTVString = "Trending TV Show"
    static let topRatedMovieString = "Top Rated Movies"
    static let topRatedTVString = "Top Rated TV Show"
    static let movieSearchString = "Movie Search"
    static let tvSearchString = "TV Search"
    static let movieSearchHint = "Search Movie"
    static let tvSearchHint = "Search TV Show"
    
    static let homeIconString = "play.house"
    static let comingSoonIconString = "play.rectangle.on.rectangle.circle"
    static let searchIconString = "magnifyingglass.circle"
    static let downloadIconString = "square.and.arrow.down"
    static let tvIconString = "tv"
    static let movieIconString = "movieclapper"
    
    
    static let homeTestMovieUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyXIypPAnfQymtyWsv19Kp2doaz53R7qosQQ&s"
    static let testMovieURL = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVRnJxini1jaWv9fnZfUc_SGQPNhV-b7CpGw&s"
    static let testMovieURL1 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_wMTrznkiPxdfKvlXKl0_fsy0fmlmQhNapA&s"
    static let testMovieURL2 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_Dp3Bg_baufEPec5eSEhbOnszOxaG7vESyw&s"
    static let testMovieURL3 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX08yAHh6PZSl0e0rqVyqfQwUbFJatGAOU-g&s"
    
    static let testMovieURL4 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQY1jCuIHaO9Mkx5_Vdd5BqfmBieaTspuK6ZQ&s"
    
    static let posterURLStart = "https://image.tmdb.org/t/p/w500"
    
    static func addPosterPath(to titles: inout[Title]){
        for index in titles.indices{
            if let path = titles[index].posterPath{
                titles[index].posterPath = Constants.posterURLStart + path
            }
        }
    }
}

enum YoutubeURLStrings: String {
    case trailer = "trailer"
    case queryShorten = "q"
    case space = " "
    case key = "key"
}

extension Text{
    func button() -> some View{
        self
            .frame(maxWidth: .infinity, minHeight: 50)
            .padding(.horizontal, 20)
            .foregroundStyle(.buttonText)
            .contentShape(Rectangle())
            .bold()
            .background{
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(.buttonBorder,lineWidth: 2)
            }
    }
}

extension Text{
    func errorMessage() -> some View{
        self
            .foregroundStyle(.red)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 10))

    }
}

