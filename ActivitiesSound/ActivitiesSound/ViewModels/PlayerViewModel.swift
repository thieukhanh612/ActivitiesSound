//
//  PlayerViewModel.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 20/11/2021.
//

import Foundation

class PlayerViewModel: ObservableObject{
    @Published var showPlayer: Bool
    @Published var currentTrack: AudioTrack?
    init(){
        self.showPlayer = false
        self.currentTrack = PlaybackPresenter.shared.currentTrack
    }
}
