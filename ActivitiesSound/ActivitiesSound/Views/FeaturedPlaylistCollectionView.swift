//
//  FeaturedPlaylistCollectionView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 18/11/2021.
//

import SwiftUI

struct FeaturedPlaylistCollectionView: View {
    var featuredPlaylist: [FeaturedPlaylistCellViewModel]
    var playlists: [Playlist]
    @ObservedObject var playerViewModel: PlayerViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text("Featured Playlists")
                .font(.title)
                .foregroundColor(Color("TextColor"))
                .bold()
                .padding(.horizontal, 20)
            ScrollView(.horizontal){
                
                HStack {
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
        .padding(.horizontal, 10)
        
    
    }
}

struct FeaturedPlaylistCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedPlaylistCollectionView(featuredPlaylist: [], playlists: [], playerViewModel: PlayerViewModel())
            .background(Color.black)
    }
}

struct PlaylistView: View {
    var featuredPlaylist: FeaturedPlaylistCellViewModel
    var body: some View {
        VStack(spacing: 10){
            if #available(iOS 15.0, *) {
                AsyncImage(url:  featuredPlaylist.artworkURl){ image in
                    image.resizable()
                } placeholder: {
                    
                    Image(systemName: "personal")
                    
                }
                .cornerRadius(10)
                .frame(width: 100 , height: 100)

            } else {
                // Fallback on earlier versions
            }
            
            Text(featuredPlaylist.name)
                .font(.body)
                .foregroundColor(Color("TextColor"))
                .multilineTextAlignment(.center)
            Text(featuredPlaylist.creatorName)
                .foregroundColor(.gray)
        }
        .frame(width: 100, height: 180)
    }
}
