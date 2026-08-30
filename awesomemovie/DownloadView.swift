//
//  DownloadView.swift
//  awesomemovie
//
//  Created by Danya on 26.08.2026.
//

import SwiftUI
import SwiftData

struct DownloadView: View {
    
    @Query(sort: \Title.title) var savedTitles: [Title]
    var body: some View {
        NavigationStack{
            if savedTitles.isEmpty{
                Text("No Downloads")
                    .padding()
                    .font(.title3)
                    .bold()
            }else{
                verticallistview(titles:savedTitles, canDelete:true)
            }
        }
    }
}

#Preview {
    DownloadView()
}
