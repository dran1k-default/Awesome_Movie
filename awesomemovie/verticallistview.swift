//
//  verticallistview.swift
//  awesomemovie
//
//  Created by Danya on 26.08.2026.
//

import SwiftUI
import SwiftData

struct verticallistview: View {
    var titles: [Title]
    let canDelete: Bool
    @Environment(\.modelContext) var modelcontext
    var body: some View {
        List(titles) {title in
            NavigationLink{
                TitleDetailView(title: title)
                
            }label: {
                AsyncImage(url: URL(string: title.posterPath ?? "" )){image in
                    HStack {
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 10))
                            .padding(5)
                        
                        Text((title.name ?? title.title) ?? "")
                            .font(.system(size:14))
                            .bold()
                    }
                    
                }placeholder:{
                        ProgressView()
                    }
                .frame(height: 150)

            }.swipeActions(edge: .trailing) {
                if canDelete{
                    Button{
                        modelcontext.delete(title)
                        try? modelcontext.save()
                        
                    }label: {
                        Image(systemName: "trash")
                            .tint(.red)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    verticallistview(titles: Title.previewTitles, canDelete: true)
}
