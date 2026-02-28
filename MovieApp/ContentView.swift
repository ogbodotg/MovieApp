//
//  ContentView.swift
//  MovieApp
//
//  Created by OGBODO on 18/02/2026.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView{
            
            ForEach(AppTab.allCases, id: \.self) { tab in
                tab.view
                             .tabItem {
                                 Label(tab.title, systemImage: tab.icon)
                             }
                     }
        }

    }
}

#Preview {
    ContentView()
}
