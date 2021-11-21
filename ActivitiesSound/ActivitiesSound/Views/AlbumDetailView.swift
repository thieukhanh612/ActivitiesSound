//
//  AlbumDetailView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/1/21.
//

import SwiftUI

struct AlbumDetailView: View {
    var album: Album
    @State var tracks :[AudioTrack] = []
    @State var viewModel :[AlbumCollectionViewCellViewModel] = []
    @ObservedObject var playerViewModel: PlayerViewModel
    var body: some View {
        ZStack {
            Color("BackgroundDefaultColor")
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    if #available(iOS 15.0, *) {
                        AsyncImage(url:  URL(string: album.images.first?.url ?? "")){ image in
                            image.resizable()
                        } placeholder: {
                            
                            Image(systemName: "personal")
                            
                        }
                        .frame(width: 328 , height: 328, alignment: .center)
                        
                    } else {
                        // Fallback on earlier versions
                    }
                    VStack(alignment: .leading) {
                        Text(album.name)
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.horizontal, 10)
                        Text("Release Date: \(album.release_date)")
                            .foregroundColor(.gray)
                            .font(.body)
                            .padding(.top, 5)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 10)
                        
                    }
                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    HStack(alignment: .top) {
                        Text(album.artists.first?.name ?? "")
                            .foregroundColor(.gray)
                            .font(.body)
                            .padding(.horizontal, 10)
                        Spacer()
                        Button(action:{
                            PlaybackPresenter.shared.player?.pause()
                            PlaybackPresenter.shared.startsPlayback(tracks: tracks)
                            playerViewModel.showPlayer = true
                            playerViewModel.currentTrack = PlaybackPresenter.shared.currentTrack
                        }) {
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
                                    SongsView(song: viewModel[value])
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .onAppear(perform: {
            APICaller.shared.getAlbumDetails(for: album, completion: { result in
                DispatchQueue.main.async {
                    switch result{
                    case .success(let model):
                        self.tracks = model.tracks.items
                        self.viewModel = model.tracks.items.compactMap({
                            AlbumCollectionViewCellViewModel(name: $0.name, artistName: $0.artists.first?.name ?? "")
                        })
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            })
        })
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .principal, content: {
                
                Text(album.name)
                    .font(.headline)
                    .foregroundColor(.black)
                
                
            })
        })
        
    }
}
struct SongsView: View {
    var song: AlbumCollectionViewCellViewModel
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.init(red: 50/255, green: 50/255, blue: 50/255, opacity: 0.8),.init(red: 42/255, green: 42/255, blue: 42/255, opacity: 0.8),.init(red: 39/255, green: 39/255, blue: 39/255, opacity: 1.0)]), startPoint: .top , endPoint: .bottom)
            HStack{
                Rectangle()
                    .frame(width: 80, height: 80)
                    .background(LinearGradient(gradient: Gradient(colors: [.init(red: 50/255, green: 50/255, blue: 50/255, opacity: 0.8),.init(red: 42/255, green: 42/255, blue: 42/255, opacity: 0.8),.init(red: 39/255, green: 39/255, blue: 39/255, opacity: 1.0)]), startPoint: .top , endPoint: .bottom)
)
                VStack(alignment: .leading){
                    Text(song.name)
                        .foregroundColor(.white)
                        .font(.footnote)
                        .padding(.top, 10)
                    Spacer()
                    Text(song.artistName)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                }
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20, height: 80)
        .cornerRadius(5.0)
        .padding(.horizontal, 10)
    }
}

    //struct AlbumDetailView_Previews: PreviewProvider {
    //    static var previews: some View {
    ////        AlbumDetailView()
    //    }
    //}
