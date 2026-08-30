//
//  ContentView.swift
//  blossommowie
//
//  Created by Danya on 09.08.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Tab(Constatns.homeString,systemImage: Constatns.homeIconString){
                Homeview()}
            Tab(Constatns.upcomingString,systemImage: Constatns.upcomingIconString){
                UpcomingView()}
            Tab(Constatns.searchString,systemImage: Constatns.searchIconString){
                SearchView()}
            Tab(Constatns.savedString,systemImage: Constatns.savedIconString){
                DownloadView()}
            
                
            
                
            }

    }
}

#Preview {
    ContentView()
}
