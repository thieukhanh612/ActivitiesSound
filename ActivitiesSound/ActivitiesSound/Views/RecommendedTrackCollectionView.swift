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
                .foregroundColor(.white)
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
                            TrackView(recommendedTrack: recommendedTracks[value])
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
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.init(red: 50/255, green: 50/255, blue: 50/255, opacity: 0.8),.init(red: 42/255, green: 42/255, blue: 42/255, opacity: 0.8),.init(red: 39/255, green: 39/255, blue: 39/255, opacity: 1.0)]), startPoint: .top , endPoint: .bottom)
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
                        .foregroundColor(.white)
                        .font(.footnote)
                        .padding(.top, 10)
                    Spacer()
                    Text(recommendedTrack.artistName)
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
