//
//  NewReleasesCellViewModel.swift
//  Spotify
//
//  Created by Дмитрий Старков on 15.04.2021.
//

import Foundation

struct NewReleasesCellViewModel: Hashable {
    let name: String
    let artworkURL: URL?
    let numberOfTracks: Int
    let artistName: String
}
