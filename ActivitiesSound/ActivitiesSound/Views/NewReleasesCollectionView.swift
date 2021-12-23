//
//  NewReleasesCollectionView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 18/11/2021.
//

import SwiftUI

struct NewReleasesCollectionView: View {
    var gridItemLayout = Array(repeating: GridItem(.flexible()), count: 3)
    var models: [NewReleasesCellViewModel]
    var albums: [Album]
    @ObservedObject var playerViewModel: PlayerViewModel
    var body: some View {
        VStack(alignment: .leading){
            Text("New Releases")
                .font(.title)
                .bold()
                .foregroundColor(Color("TextColor"))
                .padding(.horizontal, 20)
            ScrollView(.horizontal){
                LazyHGrid(rows:gridItemLayout, spacing: 8){
                    ForEach(0 ..< models.count, id: \.self){ value in
                        let model = models[value]
                        NavigationLink(destination: AlbumDetailView(album: albums[value], playerViewModel: playerViewModel)) {
                            AlbumView(model: model)
                        }
                    }
                }
            }
            .frame(height: 260)
        }
        .padding(.horizontal, 10)
        .frame(height: 350)
    }
}
struct NewRelasesCollectionViewPreview: PreviewProvider{
    static var previews: some View {
        NewReleasesCollectionView(models: [], albums: [], playerViewModel: PlayerViewModel())
    }
}
