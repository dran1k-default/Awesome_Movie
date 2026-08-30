//
//  UpcomingView.swift
//  awesomemovie
//
//  Created by Danya on 26.08.2026.
//

import SwiftUI

struct UpcomingView: View {
    let viewModel = ViewModel()
    
    
    var body: some View {
        NavigationStack {
            GeometryReader{geo in
                switch viewModel.upcomingStatus {
                case .notStarted:
                    EmptyView()
                case .Fetching:
                    ProgressView()
                        .frame(width: geo.size.width, height: geo.size.height)
                case .success:
                    verticallistview(titles: viewModel.upcomingMovies, canDelete: false)
                case .failed(let underlyingError):
                    Text(underlyingError.localizedDescription)
                        .errorMessage()
                        .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            .task {
                await viewModel.getUpcomingMovies()
            }
        }
        
    }
}

#Preview {
    UpcomingView()
}
