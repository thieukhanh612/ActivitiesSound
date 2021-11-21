//
//  PlaylistDetailView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 19/11/2021.
//

import SwiftUI

struct PlaylistDetailView: View {
    var playlist: Playlist
    @State var tracks :[AudioTrack] = []
    @State var viewModel :[RecommendedTrackCellViewModel] = []
    @ObservedObject var playerViewModel: PlayerViewModel
    var body: some View {
        ZStack {
            Color("BackgroundDefaultColor")
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    if #available(iOS 15.0, *) {
                        AsyncImage(url:  URL(string: playlist.images.first?.url ?? "")){ image in
                            image.resizable()
                        } placeholder: {
                            
                            Image(systemName: "personal")
                            
                        }
                        .frame(width: 328 , height: 328, alignment: .center)
                        
                    } else {
                        // Fallback on earlier versions
                    }
                    VStack(alignment: .leading) {
                        Text(playlist.name)
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.horizontal, 10)
                        Text(playlist.description)
                            .foregroundColor(.gray)
                            .font(.body)
                            .padding(.top, 5)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 10)
                        
                    }
                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    HStack(alignment: .top) {
                        Text(playlist.owner.display_name)
                            .foregroundColor(.gray)
                            .font(.body)
                            .padding(.horizontal, 10)
                        Spacer()
                        Button(action:{
                            PlaybackPresenter.shared.player?.pause()
                            PlaybackPresenter.shared.startsPlayback(tracks: tracks)
                            playerViewModel.showPlayer = true
                            playerViewModel.currentTrack = PlaybackPresenter.shared.currentTrack
                        }){
                            Image(systemName: "play.circle.fill")
                                .resizable()
                                .foregroundColor(.green)
                                .background(Color.white)
                                .clipShape(Circle())
                                .frame(width: 64, height: 64)
                                .padding(.horizontal, 5)
                        }
                    }
                    ScrollView{
                        VStack {
                            ForEach( 0 ..< viewModel.count, id: \.self){ value in
                                Button(action:{
                                    PlaybackPresenter.shared.playerQueue?.pause()
                                    PlaybackPresenter.shared.startPlayback(track: tracks[value])
                                    playerViewModel.currentTrack = tracks[value]
                                    if playerViewModel.currentTrack?.preview_url != nil{
                                        playerViewModel.showPlayer = true
                                    }
                                }) {
                                    TrackView(recommendedTrack: viewModel[value])
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .onAppear(perform: {
            APICaller.shared.getPlaylistDetails(for: playlist){ [self] result in
                DispatchQueue.main.async {
                    switch result{
                    case .success(let model):
                        self.tracks = model.tracks.items.compactMap{$0.track}
                        self.viewModel = model.tracks.items.compactMap({RecommendedTrackCellViewModel(name: $0.track.name, artistName: $0.track.artists.first?.name ?? "", atrworkURL: URL(string: $0.track.album?.images.first?.url ?? ""))})
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        })
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .principal, content: {
                HStack {
                    Spacer()
                    Text(playlist.name)
                        .font(.headline)
                        .foregroundColor(.black)
                    Spacer()
                    Button(action: shareButton) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.black)
                    }
                }
            })
        })
        
    }
    func shareButton(){
        
        let url = URL(string: playlist.external_urls["spotify"]!)
        let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
}

struct PlaylistDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlaylistDetailView(playlist: .init(description: "", external_urls: ["":""], id: "", images: [], name: "", owner: .init(display_name: "", external_urls: ["":""], id: "")), playerViewModel: PlayerViewModel())
        }
    }
}
