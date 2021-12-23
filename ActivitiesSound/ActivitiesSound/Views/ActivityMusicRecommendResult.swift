//
//  ActivityMusicRecommendResult.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 27/11/2021.
//

import SwiftUI

struct ActivityMusicRecommendResult: View {
    @State var result: [SearchResult] = []
    @ObservedObject var playerViewModel: PlayerViewModel
    var option: DropdownOption
    var dict : [String:[String]] = [
        "Normal cooking":["cooking music", "home cooking", "cooking and drinking"],
        "Making cake":["making cake", "baking"],
        "Outside cooking":["BBQ music","camping music","cooking outside", "sitting outside","eating outside"],
        "Workout": ["workout music" , "rap, pop, rock, mix workout music", "fitness", "yoga", "aerobic", "workout music"],
        "Walking":["music for walking", "Cardio music", "workout music", "dog walking music", "walking fitnesss music"],
        "Skilled trades":["Construction music", "Smart construction", "Motive power music" , "Industrial", "laudry service", "room hotel service", "service music"],
        "Technical":["study", "technical","study chill lofi"],
        "Tatical games":["Fps gaming music", "moba gaming music","gaming music"],
        "Video games":["music for videogame", "Video game", "gaming music"],
        "Housework":["housework music", "housework mix" ,"household chore"],
        "Sleeping":["sleeping music", "piano for sleeping", "white noise for sleeping"],
        "Chillout":["chillout music", "classic chillout", "work chillout music","study chillout music", "cafe chillout"],
        "Fun mood":["fun", "Mood lifiting"],
        "Sad mood":["sad", "lofi sad mood","sad mood night"],
        "Dance":["hiphop dance" ," party song", "dance music"]
        
    ]
    var body: some View {
        ZStack {Color("BackgroundDefaultColor")
                .ignoresSafeArea()
            ScrollView{
                VStack(alignment: .leading ){
                    if result.isEmpty {
                        
                        Text("No result")
                    }
                    else{
                        let artist = result.filter({
                            switch $0{
                            case .artist: return true
                            default: return false
                            }
                        })
                        let album = result.filter({
                            switch $0 {
                            case .album: return true
                            default: return false
                            }
                        })
                        let track = result.filter({
                            switch $0{
                            case .track: return true
                            default: return false
                            }
                        })
                        let playlist = result.filter({
                            switch $0{
                            case .playlist: return true
                            default: return false
                            }
                        })
                        SectionView(title: "artist", result: artist, playerViewModel:playerViewModel)
                        SectionView(title: "album", result: album, playerViewModel: playerViewModel)
                        SectionView(title: "track", result: track, playerViewModel:playerViewModel)
                        SectionView(title: "playlist", result: playlist, playerViewModel:playerViewModel)
                    }
                }
            }
            .padding(.horizontal, 20)
            
        }
        .onAppear(perform: {
            let keySearches = dict[option.value]!
                        
            for keySearch in keySearches {
                APICaller.shared.search(with: keySearch){result in
                    DispatchQueue.main.async {
                        switch result{
                        case .success(let results):
                            for result in results {
                                self.result.append(result)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            
        })
        
    }
}

struct ActivityMusicRecommendResult_Previews: PreviewProvider {
    static var previews: some View {
        ActivityMusicRecommendResult(playerViewModel: PlayerViewModel(), option: DropdownOption(key: UUID().uuidString, value: "Normal cooking"))
    }
}
