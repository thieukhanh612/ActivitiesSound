//
//  RecommendedTrackCollectionView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 18/11/2021.
//

import SwiftUI

struct RecommendedTrackCollectionView: View {
    var recommendedTracks: [RecommendedTrackCellViewModel]
    var tracks: [AudioTrack]
    @ObservedObject var playerViewModel: PlayerViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended")
                .font(.title)
                .foregroundColor(Color("TextColor"))
                .bold() 
                .padding(.horizontal, 20)
            ScrollView {
                
                VStack {
                    ForEach( 0 ..< recommendedTracks.count, id: \.self){ value in
                        Button(action:{
                            PlaybackPresenter.shared.playerQueue?.pause()
                            PlaybackPresenter.shared.startPlayback(track: tracks[value])
                            playerViewModel.currentTrack = tracks[value]
                            if playerViewModel.currentTrack?.preview_url != nil{
                                playerViewModel.showPlayer = true
                            }
                        }) {
                            TrackView(recommendedTrack: recommendedTracks[value], track: tracks[value])
                        }
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20)
        .padding(.horizontal, 10)
    }
}

struct RecommendedTrackCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedTrackCollectionView(recommendedTracks: [], tracks: [], playerViewModel:PlayerViewModel())
    }
}

struct TrackView: View {
    var recommendedTrack : RecommendedTrackCellViewModel
    var track: AudioTrack
    var isUserLibrary : Bool = false
    @State var playlistSelected: Playlist = Playlist.init(description: "", external_urls: ["":""], id: "", images: [], name: "", owner: .init(display_name: "", external_urls: ["":""], id: ""))
    @State var showAlert: Bool = false
    @State var success: Bool = false
    var body: some View {
        ZStack {
            Color("TextColor")
                .ignoresSafeArea()
            HStack{
                if #available(iOS 15.0, *) {
                    AsyncImage(url: recommendedTrack.atrworkURL){ image in
                        image.resizable()
                    } placeholder: {
                        
                        Image(systemName: "personal")
                        
                    }
                    .frame(width: 80 , height: 80)

                } else {
                    // Fallback on earlier versions
                }
                VStack(alignment: .leading){
                    Text(recommendedTrack.name)
                        .foregroundColor(Color("BackgroundDefaultColor"))
                        .font(.footnote)
                        .padding(.top, 10)
                    Spacer()
                    Text(recommendedTrack.artistName)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                }
                
                Spacer()
                if !isUserLibrary{
                    NavigationLink(destination:{
                        SelectPlaylist(track: track)
                    }){
                        Image(systemName: "plus")
                            .frame(width: 20,height: 20)
                            .foregroundColor(Color("BackgroundDefaultColor"))
                            .padding(.trailing, 10)
                    }
                }
                else{
                    Button(action:{
                        APICaller.shared.removeTrackFromPlaylist(track: track, playlist: playlistSelected){ result in
                            switch result{
                            case true:
                                success = true
                            case false:
                                success = false
                            }
                        }
                        showAlert = true
                        success = true
                    }){
                        Image(systemName: "minus")
                            .frame(width: 20,height: 20)
                            .foregroundColor(Color("BackgroundDefaultColor"))
                            .padding(.trailing, 10)
                    }
                }
                
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20, height: 80)
        .cornerRadius(5.0)
        .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 2)
            )
        .padding(.horizontal, 10)
        .alert(isPresented: $showAlert){
            Alert(
                title:Text( success ? "Successfully" : "Error"),
                message: Text(success ? "\(track.name) is removed to \(playlistSelected.name) successfuly" : "Please try again"),
                dismissButton: .default(Text("Okay"), action: {
                    
                })
            )
            
        }
    }
}
