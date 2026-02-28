//
//  DetailsView.swift
//  MovieApp
//
//  Created by OGBODO on 23/02/2026.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.dismiss) var dismiss
    let title: Title
    var titleName: String {
        return (title.name ?? title.title) ?? ""
    }
    let viewModel = ViewModel()
    @Environment(\.modelContext) var modelContext
    
    
    var body: some View {
        GeometryReader{geo in
            switch viewModel.videoIdStatus {
            case .notStarted:
                EmptyView()
            case .fetching:
                ProgressView()
                    .frame(width: geo.size.width, height: geo.size.height)
            case .success:
                ScrollView {
                    LazyVStack(alignment: .leading){
                        YoutubePlayer(videoId: viewModel.videoId)
                            .aspectRatio(1.3, contentMode: .fit)
    //                    AsyncImage(url: URL(string: title.posterPath ?? "")) { image in
    //                        image
    //                            .resizable()
    //                            .scaledToFit()
    //
    //                    } placeholder: {
    //                        ProgressView()
    //                    }
    //                    .frame(width: geo.size.width, height: geo.size.height*0.85)
                        
                        Text(titleName)
                            .bold()
                            .font(.title2)
                            .padding(5)
                     
                        
                        Text(title.overview ?? "")
                            .padding(5)
                        
                        HStack{
                            Spacer()
                            Button {
                                let saveTitle = title
                                saveTitle.title = titleName
                                modelContext.insert(saveTitle)
                                try? modelContext.save()
                                dismiss()
                            } label: {
                                Text(Constants.downloadString)
                                    .button()
                            }
                            Spacer()
                        }

                    }
                }
            case .failed(let underlyingError):
                Text(underlyingError.localizedDescription)
                    .errorMessage()
                    .frame(width: geo.size.width, height: geo.size.height)
            }
        }
        .task {
            await viewModel.getVideoId(for: titleName)
        }
    }
}
#Preview {
    DetailsView(title: Title.previewTitles[0])
}
