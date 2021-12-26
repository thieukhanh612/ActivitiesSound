//
//  NewReleasesCellViewModel.swift
//  Spotify
//
//  Created by  on 15.12.2021.
//

import Foundation

struct NewReleasesCellViewModel: Hashable {
    let name: String
    let artworkURL: URL?
    let numberOfTracks: Int
    let artistName: String
}
