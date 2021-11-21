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
            LinearGradient(gradient: Gradient(colors: [.init(red: 50/255, green: 50/255, blue: 50/255, opacity: 0.8),.init(red: 42/255, green: 42/255, blue: 42/255, opacity: 0.8),.init(red: 39/255, green: 39/255, blue: 39/255, opacity: 1.0)]), startPoint: .top , endPoint: .bottom)
            HStack{
                if #available(iOS 15.0, *) {
                    AsyncImage(url:  model.artworkURL){ image in
                        image.resizable()
                    } placeholder: {
                        
                        Image(systemName: "personal")
                        
                    }
                    .frame(width: 80 , height: 80)

                } else {
                    // Fallback on earlier versions
                }
                VStack(alignment: .leading){
                    Text(model.name)
                        .font(.footnote)
                        .foregroundColor(.white)
                        .bold()
                        .padding(.vertical, 2)
                        
                    Spacer()
                    Text(model.artistName)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .bold()
                    Text("Tracks: \(model.numberOfTracks)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .bold()
                        .padding(.bottom, 2)
                }
            }
        }
        .frame(width: 300, height: 80)
        .cornerRadius(5)
        .ignoresSafeArea()
        
        
    }
}
