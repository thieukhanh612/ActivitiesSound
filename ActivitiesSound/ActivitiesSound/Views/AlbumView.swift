//
//  SwiftUIView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/1/21.
//

import SwiftUI

struct AlbumView: View {
    var albumName: String
    var albumQuantity: Int
    var albumType: String
    var body: some View {
        ZStack(alignment: .leading){
            Color(red: 20/255, green: 25/255, blue: 39/255, opacity: 1)
                .ignoresSafeArea(.all)
            VStack(alignment: .leading){
                ZStack(alignment: .topTrailing){
                    Image("AlbumImage_2")
                        .resizable()
                        .cornerRadius(16.0)
                        .scaledToFill()
                    
                    CustomCircleView()
                        .padding(8.0)
                }
                
                Text(albumName)
                    .foregroundColor(.white)
                    .font(.body)
                Text("\(albumQuantity) Songs - \(albumType)")
                    .foregroundColor(Color( red: 235, green: 235, blue: 245, opacity: 0.6))
                    .font(.footnote)
            }
        }
        .scaledToFit()
        .ignoresSafeArea()
        
        
    }
}
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(albumName: "Guitar Camp", albumQuantity: 7, albumType: "Instrumental")
    }
}
