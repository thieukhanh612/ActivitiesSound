//
//  SwiftUIView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/1/21.
//

import SwiftUI

struct AlbumView: View {
    var model: NewReleasesCellViewModel
    var body: some View {
        ZStack(alignment: .leading){
            Color("TextColor")
                .ignoresSafeArea()
            HStack{
                if #available(iOS 15.0, *) {
                    AsyncImage(url:  model.artworkURL){ image in
                        image.resizable()
                    } placeholder: {
                        
                        Image(systemName: "personal")
                        
                    }
                    .frame(width: 80 , height: 80)
                    .padding(.horizontal, 5)

                } else {
                    // Fallback on earlier versions
                }
                VStack(alignment: .leading){
                    Text(model.name)
                        .font(.footnote)
                        .foregroundColor(Color("BackgroundDefaultColor"))
                        .bold()
                        .padding(.vertical, 2)
                        
                    Spacer()
                    Text(model.artistName)
                        .font(.footnote)
                        .foregroundColor(Color("SubTextColor"))
                        .bold()
                    Text("Tracks: \(model.numberOfTracks)")
                        .font(.footnote)
                        .foregroundColor(Color("SubTextColor"))
                        .bold()
                        .padding(.bottom, 2)
                }
                Spacer()
            }
        }
        .frame(width: 300, height: 80)
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 2)
        )
        .ignoresSafeArea()
    }
}
