//
//  Homeview.swift
//  blossommowie
//
//  Created by Danya on 10.08.2026.
//

import SwiftUI
import SwiftData

struct Homeview: View {
    
        let viewModel = ViewModel()
        @State private var titleDetailPath = NavigationPath()
        @Environment(\.modelContext) var modelContext
    var body: some View {
        NavigationStack(path: $titleDetailPath) {
            GeometryReader {geo in
                ScrollView(.vertical) {
                    switch viewModel.homeStatus {
                    case .notStarted:
                        EmptyView()
                    case .Fetching:
                        ProgressView()
                            .frame(width: geo.size.width, height: geo.size.height)
                    case .success:
                        LazyVStack{
                            AsyncImage(url: URL(string:viewModel.heroTitle.posterPath ?? "")){ image in image
                                    .resizable()
                                    .scaledToFit()
                                    .overlay{LinearGradient(
                                        stops: [Gradient.Stop(color: .clear, location: 0.8), Gradient.Stop(color: .gradient, location: 1.0)],
                                        startPoint: .top,
                                        endPoint: .bottom)}}
                            placeholder :{ProgressView()}
                                .frame(width: geo.size.width, height: geo.size.height * 0.85)
                            
                            HStack {
                                Button {
                                    titleDetailPath.append(viewModel.heroTitle)
                                    
                                } label: { Text(Constatns.playString)
                                        .ghostButton()
                                    
                                }
                                Button {
                                    modelContext.insert(viewModel.heroTitle)
                                    try? modelContext.save()
                                    
                                } label: { Text(Constatns.saveString)
                                        .ghostButton()
                                }
                                
                            }
                            
                            
                            
                            HorizontalListView(header: Constatns.trendingsMowieString, titles: viewModel.trdendingMovies){title in
                                titleDetailPath.append(title)}
                            
                            HorizontalListView(header: Constatns.trendingTVString, titles: viewModel.trendingTV){title in
                                titleDetailPath.append(title)}
                            
                            HorizontalListView(header: Constatns.topRatedMowieString, titles: viewModel.topRatedMovies){title in
                                titleDetailPath.append(title)}
                            
                            HorizontalListView(header: Constatns.topRatedTVString, titles: viewModel.topRatedTV){title in
                                titleDetailPath.append(title)}
                        }
            
                        
                    case .failed(let error):
                        Text(error.localizedDescription)
                            .errorMessage()
                            .frame(width: geo.size.width, height: geo.size.height)

                        
                    }
                    
                }.task{
                    await viewModel.getTitles()
                }
                .navigationDestination(for: Title.self) { title in
                    TitleDetailView(title: title)
                    
                }
            }
        }
    }
}

#Preview {
    Homeview()
}
