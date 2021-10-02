//
//  UserProfileView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/2/21.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        ZStack{
            Color("BackgroundDefaultColor")
                .ignoresSafeArea()
            GeometryReader { geometry in
                VStack{
                    HStack{
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(maxWidth: geometry.size.width / 5, maxHeight: geometry.size.width / 5)
                            .scaledToFit()
                            .padding()
                        VStack(alignment: .leading,spacing: 10){
                            Text("Name: Kean")
                                .foregroundColor(.white)
                                .font(.body)
                                .fontWeight(.bold)
                            Text("DOB: 06/12/2000")
                                .foregroundColor(.white)
                                .font(.body)
                                .fontWeight(.bold)
                        }
                        .padding()
                        .background(Color( red: 33/255, green: 40/255, blue: 63/255, opacity: 1.0))
                        .cornerRadius(16.0)
                        .scaledToFill()

                            
                    }
                    .frame(maxHeight: geometry.size.height / 5)
                    Divider()
                        .background(Color(.white))
                        .padding(.vertical)
                    VStack(alignment: .leading){
                        Text("Album charged")
                            .font(.body)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        ScrollView(.horizontal){
                            HStack(spacing: 15) {
                                AlbumView(albumName: "Guitar Camp", albumQuantity: 7, albumType: "Instrumental")
                                    .frame(maxWidth: geometry.size.width / 3)
                                AlbumView(albumName: "Guitar Camp", albumQuantity: 7, albumType: "Instrumental")
                                    .frame(maxWidth: geometry.size.width / 3)
                                AlbumView(albumName: "Guitar Camp", albumQuantity: 7, albumType: "Instrumental")
                                    .frame(maxWidth: geometry.size.width / 3)
                                
                            }
                            
                                
                        }
                        
                    }
                    .padding()
                    .frame(maxHeight: geometry.size.height / 4)
                    Divider()
                        .background(Color(.white))
                        .padding(.vertical)
                    VStack(alignment: .leading){
                        Text("Recently Seen")
                            .font(.body)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        ScrollView(.horizontal){
                            HStack(spacing: 15) {
                                AlbumView(albumName: "Guitar Camp", albumQuantity: 7, albumType: "Instrumental")
                                    .frame(maxWidth: geometry.size.width / 3)
                                AlbumView(albumName: "Guitar Camp", albumQuantity: 7, albumType: "Instrumental")
                                    .frame(maxWidth: geometry.size.width / 3)
                                AlbumView(albumName: "Guitar Camp", albumQuantity: 7, albumType: "Instrumental")
                                    .frame(maxWidth: geometry.size.width / 3)
                                
                            }
                                                            
                        }
                        
                    }
                    .padding()
                    .frame(maxHeight: geometry.size.height / 4)

                }
                .padding()
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
