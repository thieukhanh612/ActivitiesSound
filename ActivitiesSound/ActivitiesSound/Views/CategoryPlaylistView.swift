//
//  CategoryView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 20/11/2021.
//

import SwiftUI

struct CategoryPlaylistView: View {
    var gridItemLayout = Array(repeating: GridItem(.flexible()), count: 3)
    @State var featuredPlaylist: [FeaturedPlaylistCellViewModel] = []
    @State var playlists: [Playlist] = []
    @ObservedObject var playerViewModel: PlayerViewModel
    var category: Category
    var body: some View {
        ZStack {
            Color("BackgroundDefaultColor")
                .ignoresSafeArea()
            ScrollView {
                VStack{
                    LazyVGrid(columns: gridItemLayout){
                        ForEach(0 ..< featuredPlaylist.count, id: \.self){ value in
                            let featuredPlaylist = featuredPlaylist[value]
                            let playlist = playlists[value]
                            NavigationLink( destination: {
                                PlaylistDetailView(playlist: playlist, playerViewModel: playerViewModel)
                            }) {
                                PlaylistView(featuredPlaylist: featuredPlaylist )
                                    
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .principal, content: {
                Text(category.name)
                    .foregroundColor(Color("TextColor"))
                    .bold()
            })
        })
        .onAppear(perform: {
            APICaller.shared.getCategoryPlaylists(category: category){ [self] result in
                DispatchQueue.main.async {
                    switch result{
                    case .success(let playlist):
                        self.playlists = playlist
                        self.featuredPlaylist = playlist.compactMap({
                            return FeaturedPlaylistCellViewModel(name: $0.name, artworkURl: URL(string: $0.images.first?.url ?? ""), creatorName: $0.owner.display_name)
                        })
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        })
    }
}

struct CategoryPlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPlaylistView(featuredPlaylist: [], playlists: [], playerViewModel: PlayerViewModel(), category: .init(id: "", name: "", icons: []))
    }
}
