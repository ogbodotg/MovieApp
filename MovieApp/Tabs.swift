//
//  Tabs.swift
//  MovieApp
//
//  Created by OGBODO on 18/02/2026.
//

import SwiftUICore

enum AppTab: CaseIterable {
    case home, comingSoon, search, download

    var title: String {
        switch self {
        case .home: return Constants.homeString
        case .comingSoon: return Constants.comingSoonMoviesString
        case .search: return Constants.searchString
        case .download: return Constants.downloadString
            
        }
    }

    var icon: String {
        switch self {
        case .home: return Constants.homeIconString
        case .comingSoon: return Constants.comingSoonIconString
        case .search: return Constants.searchIconString
        case .download: return Constants.downloadIconString

        }
    }
    
    @ViewBuilder
        var view: some View {
            switch self {
            case .home:
                HomeView()

            case .comingSoon:
                ComingSoonView()

            case .search:
                SearchView()

            case .download:
                DownloadView()
            }
        }
}
