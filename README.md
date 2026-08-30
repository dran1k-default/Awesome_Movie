# AwesomeMovie 🎬

An iOS movie & TV discovery app built with **SwiftUI** and **SwiftData**. Browse trending and top-rated titles from **TMDB**, watch trailers pulled from **YouTube**, and save favorites for later — all offline-persisted on device.

<p align="left">
  <img src="https://github.com/dran1k-default/Awesome_Movie/blob/main/Снимок%20экрана%202026—08—30%20в%2019.20.56.png" height="250">
  <img src="https://github.com/dran1k-default/Awesome_Movie/blob/main/Simulator%20Screenshot%20-%20iPhone%2017e%20-%202026-08-30%20at%2017.23.28.png" height="250">
  <img src="https://github.com/dran1k-default/Awesome_Movie/blob/main/Simulator%20Screenshot%20-%20iPhone%2017e%20-%202026-08-30%20at%2017.23.38.png" height="250">
  <img src="https://github.com/dran1k-default/Awesome_Movie/blob/main/Simulator%20Screenshot%20-%20iPhone%2017e%20-%202026-08-30%20at%2017.23.43.png" height="250">
  <img src="https://github.com/dran1k-default/Awesome_Movie/blob/main/Simulator%20Screenshot%20-%20iPhone%2017e%20-%202026-08-30%20at%2017.23.45.png" height="250">
  <img src="https://github.com/dran1k-default/Awesome_Movie/blob/main/Simulator%20Screenshot%20-%20iPhone%2017e%20-%202026-08-30%20at%2017.23.52.png" height="250">
</p>

## Features

- **Home** — a hero banner featuring a random trending title with Play/Save actions, plus horizontally scrolling rows for Trending Movies, Trending TV, Top Rated Movies, and Top Rated TV
- **Upcoming** — a browsable list of upcoming movie releases
- **Search** — live search (debounced) across movies or TV shows, with a one-tap toggle between the two
- **Saved** — a personal watchlist of saved titles, persisted locally with SwiftData, swipe to delete
- **Trailers** — tapping into a title fetches a matching trailer via the YouTube Data API and plays it in an embedded player

## Tech Stack

- Swift / SwiftUI
- SwiftData for local persistence
- `async/await` networking with `URLSession`
- [TMDB API](https://www.themoviedb.org/documentation/api) for movie & TV data
- [YouTube Data API v3](https://developers.google.com/youtube/v3) for trailer search
- `WKWebView` for embedded video playback

## Requirements

- Xcode 26 or later
- iOS 26.5+
- A [TMDB API key](https://www.themoviedb.org/settings/api)
- A [YouTube Data API v3 key](https://console.cloud.google.com/apis/library/youtube.googleapis.com)

## Getting Started

1. Clone the repo:
   ```bash
   git clone https://github.com/dran1k-default/AwesomeMovie.git
   ```
2. Open `awesomemovie.xcodeproj` in Xcode.
3. Fill in your API keys in `awesomemovie/APIConfig.json`:
   ```json
   {
       "tmdbBaseURL": "https://api.themoviedb.org",
       "tmdbAPIKey": "YOUR_TMDB_API_KEY",
       "youtubeBaseURL": "https://youtube.com/embed",
       "youtubeAPIKey": "YOUR_YOUTUBE_API_KEY",
       "youtubeSearchURL": "https://www.googleapis.com/youtube/v3/search"
   }
   ```
   > ⚠️ Don't commit real API keys — consider adding `APIConfig.json` to `.gitignore` once your keys are in place.
4. Build and run on the simulator or a device.

## Project Structure

```
awesomemovie/
├── awesomemovieAPP.swift       # App entry point
├── ContentView.swift           # Root TabView (Home / Upcoming / Search / Saved)
├── Homeview.swift               # Home tab
├── UpcomingView.swift           # Upcoming tab
├── SearchView.swift             # Search tab
├── DownloadView.swift           # Saved tab
├── TitleDetailView.swift        # Title detail + trailer
├── ViewModel.swift              # Home/Upcoming/detail view model
├── SearchViewModel.swift        # Search view model
├── DataFetcher.swift            # TMDB & YouTube networking
├── APIConfig.swift / .json      # API configuration
├── Title.swift                  # SwiftData model
├── YoutubePlayer.swift          # Trailer playback (WKWebView)
├── HorizontalListView.swift     # Horizontal poster carousel
├── verticallistview.swift       # Vertical poster list
└── constatns.swift              # Shared string/icon constants

