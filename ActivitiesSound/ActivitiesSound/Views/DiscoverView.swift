//
//  ContentView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/1/21.
//

import SwiftUI

struct DiscoverView: View {
    @State var newAlbums: [Album] = []
    @State var playlists: [Playlist] = []
    @State var tracks: [AudioTrack] = []
    @State var newReleases : [NewReleasesCellViewModel] = []
    @State var featuredPlaylist: [FeaturedPlaylistCellViewModel] = []
    @State var recommendedTracks: [RecommendedTrackCellViewModel] = []
    @ObservedObject var playerViewModel: PlayerViewModel
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.init( red: 58/255, green: 157/255, blue: 18/255, opacity: 1), .init(red: 18/255, green: 18/255, blue: 18/25)]), startPoint: .top, endPoint: .bottom)
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Browse")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                            .padding(.horizontal, 20)
                            .padding(.top, 80)
                        NewReleasesCollectionView(models: newReleases, albums: newAlbums, playerViewModel: playerViewModel)
                        FeaturedPlaylistCollectionView(featuredPlaylist: featuredPlaylist, playlists: playlists, playerViewModel: playerViewModel)
                        RecommendedTrackCollectionView(recommendedTracks: recommendedTracks,tracks: tracks, playerViewModel:playerViewModel)
                        Spacer()
                        
                        
                        
                    }
                }
            }
            .ignoresSafeArea()
            .onAppear(perform: {
                fetchData()
        })
            .navigationBarHidden(true)
        }
        .navigationBarTitle("Browse")
        .navigationBarHidden(true)
        
        
    }
    func fetchData(){
        var newReleases: NewReleasesResponse?
        var featuredPlaylist: FeaturedPlaylistResponse?
        var recommendation: RecommendationsResponse?
        
        
        
        APICaller.shared.getNewReleases{ result in
            
            switch result{
            case .success(let model):
                newReleases = model
                self.newAlbums = newReleases?.albums.items ?? []
                self.newReleases = newAlbums.compactMap({
                    return NewReleasesCellViewModel(name: $0.name, artworkURL: URL(string: $0.images.first?.url ?? ""), numberOfTracks: $0.total_tracks, artistName: $0.artists.first?.name ?? "")
                })
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        APICaller.shared.getFeaturedPlaylist{ result in
            
            switch result{
            case .success(let model):
                featuredPlaylist = model
                self.playlists = featuredPlaylist?.playlists.items ?? []
                self.featuredPlaylist = playlists.compactMap({
                    return FeaturedPlaylistCellViewModel(name: $0.name, artworkURl: URL(string: $0.images.first?.url ?? ""), creatorName: $0.owner.display_name)
                })
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
        APICaller.shared.getReccomendedGenres{ result in
            
            switch result{
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement(){
                        seeds.insert(random)
                    }
                }
                APICaller.shared.getRecomendations(genres: seeds){
                    recommendedResult in
                    switch recommendedResult{
                    case .success(let model):
                        recommendation = model
                        self.tracks = recommendation?.tracks ?? []
                        self.recommendedTracks = tracks.compactMap({
                            return RecommendedTrackCellViewModel(name: $0.name, artistName: $0.artists.first?.name ?? "-", atrworkURL: URL(string: $0.album?.images.first?.url ?? ""))
                        })
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(playerViewModel: PlayerViewModel())
    }
}

