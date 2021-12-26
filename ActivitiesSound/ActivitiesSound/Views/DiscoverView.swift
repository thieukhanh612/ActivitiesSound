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
    @State var showDropBox: Bool = false
    @State var option: DropdownOption = DropdownOption(key: UUID().uuidString, value: "")
    @State var showOptionRecommend: Bool = false
    @State var isFetched: Bool = false
    static var uniqueKey: String {
        UUID().uuidString
    }
    
    static let options: [DropdownOption] = [
        DropdownOption(key: uniqueKey, value: "Normal cooking"),
        DropdownOption(key: uniqueKey, value: "Making cake"),
        DropdownOption(key: uniqueKey, value: "Outside cooking"),
        DropdownOption(key: uniqueKey, value: "Workout"),
        DropdownOption(key: uniqueKey, value: "Walking"),
        DropdownOption(key: uniqueKey, value: "Skilled trades"),
        DropdownOption(key: uniqueKey, value: "Technical"),
        DropdownOption(key: uniqueKey, value: "Tatical games"),
        DropdownOption(key: uniqueKey, value: "Video games"),
        DropdownOption(key: uniqueKey, value: "Housework"),
        DropdownOption(key: uniqueKey, value: "Sleeping"),
        DropdownOption(key: uniqueKey, value: "Chillout"),
        DropdownOption(key: uniqueKey, value: "Fun mood"),
        DropdownOption(key: uniqueKey, value: "Sad mood"),
        DropdownOption(key: uniqueKey, value: "Dance")
    ]
    @ObservedObject var playerViewModel: PlayerViewModel
    var body: some View {
        NavigationView {
            ZStack {
                
                Color("BackgroundDefaultColor")
                    .ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading) {
                        NavigationLink(destination: ActivityMusicRecommendResult(playerViewModel: playerViewModel, option: option), isActive: $showOptionRecommend){
                            EmptyView()
                        }
                        Text("Discover")
                            .foregroundColor(Color("TextColor"))
                            .font(.largeTitle)
                            .bold()
                            .padding(.horizontal, 20)
                            .padding(.top, 80)
                        Text("What are you doing ?")
                            .foregroundColor(Color("TextColor").opacity(0.6))
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                        
                        Group {
                            DropBox(
                                shouldShowDropdown: $showDropBox,
                                placeholder: "Choose what are you doing",
                                options: DiscoverView.options,
                                onOptionSelected: { option in
                                    print(option)
                                    self.option = option
                                    showOptionRecommend = true
                                    
                                }, playerViewModel: playerViewModel)
                                .padding(.horizontal)
                        }
                        
                        
                        if showDropBox{
                            VStack{
                                
                            }.frame(height:CGFloat(DiscoverView.options.count) * 30 )
                        }
                        NewReleasesCollectionView(models: newReleases, albums: newAlbums, playerViewModel: playerViewModel)
                        FeaturedPlaylistCollectionView(featuredPlaylist: featuredPlaylist, playlists: playlists, playerViewModel: playerViewModel)
                        RecommendedTrackCollectionView(recommendedTracks: recommendedTracks,tracks: tracks, playerViewModel:playerViewModel)
                        Spacer()
                        
                        
                        
                    }
                }
            }
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .onAppear(perform: {
                if !isFetched{
                fetchData()
                }
            })
        }
        .navigationTitle("")
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
                        print(tracks)
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
        isFetched = true
    }
    
    
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(playerViewModel: PlayerViewModel())
    }
}

