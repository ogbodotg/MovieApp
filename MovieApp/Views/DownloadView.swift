//
//  DownloadView.swift
//  MovieApp
//
//  Created by OGBODO on 19/02/2026.
//

import SwiftUI
import SwiftData

struct DownloadView: View {
    @Query(sort: \Title.title) var savedTitles: [Title]
    
    var body: some View {
        NavigationStack {
            if savedTitles.isEmpty{
                Text("No Downloads")
                    .padding()
                    .font(.title3)
                    .bold()
            }else {
                VerticalListView(titles: savedTitles, allowDelete: true)
            }
        }
    }
}

#Preview {
    DownloadView()
}
