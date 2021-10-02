//
//  AlbumDetailView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/1/21.
//

import SwiftUI

struct AlbumDetailView: View {
    var body: some View {
        ZStack{
            Color("BackgroundDefaultColor")
                .ignoresSafeArea(.all)
            GeometryReader{ geometry in
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        VStack(alignment:.leading){
                            Text("Guitar Camp")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .bold()
                            Text("7 Songs - Instrumental")
                                .foregroundColor(Color( red: 235, green: 235, blue: 245, opacity: 0.6))
                                .font(.subheadline)
                            
                            Spacer()
                            Divider()
                                .background(Color(.white))
                            
                            
                        }
                        .frame(maxWidth: .infinity,maxHeight: 80, alignment: .leading)
                        
                        HStack(spacing: 15){
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                HStack{
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    Text("Unlock")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                }
                                .padding()
                            })
                            .frame(maxWidth: geometry.size.width / 2)
                            .background(Color( red: 255/255, green: 156/255, blue: 65/255, opacity: 1))
                            .cornerRadius(20.0)
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                HStack{
                                    Image(systemName: "star.leadinghalf.fill")
                                        .foregroundColor(Color( red: 255/255, green: 156/255, blue: 65/255, opacity: 1.0))
                                        .font(.headline)
                                    Text("Unfavorite")
                                        .foregroundColor(Color( red: 255/255, green: 156/255, blue: 65/255, opacity: 1.0))
                                        .font(.headline)
                                }
                                .padding()
                            })
                            .frame(maxWidth: geometry.size.width / 2)
                            .background(Color( red: 33/255, green: 40/255, blue: 63/255, opacity: 1))
                            .cornerRadius(20.0)
                            
                        }
                        .padding()
                        Divider()
                            .background(Color(.white))
                        VStack(alignment: .leading) {
                            Text("About this pack")
                                .foregroundColor(.white)
                                .font(.headline)
                            Text("An acoustic mix has been specially selected for you. The camping atmosphere will help you improve your sleep and your body as a whole. Your dreams will be delightful and vivid.")
                                .foregroundColor(Color( red: 235/255, green: 235/255, blue: 245/255, opacity: 0.6))
                                .font(.headline)
                        }
                        .padding(.vertical)
                        VStack(alignment: .leading){
                            Text("LIST OF SONGS")
                                .foregroundColor(Color( red: 235, green: 235, blue: 245, opacity: 0.6))
                                .font(.footnote)
                                .padding()
                            ScrollView(showsIndicators: true){
                                VStack(alignment: .leading) {
                                    HStack{
                                        Text("01")
                                            .foregroundColor(Color( red: 235, green: 235, blue: 245, opacity: 0.6))
                                       LockCircle()
                                        Text("The Guitar")
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical)
                                    HStack{
                                        Text("01")
                                            .foregroundColor(Color( red: 235, green: 235, blue: 245, opacity: 0.6))
                                       LockCircle()
                                        Text("The Guitar")
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical)
                                    HStack{
                                        Text("01")
                                            .foregroundColor(Color( red: 235, green: 235, blue: 245, opacity: 0.6))
                                       LockCircle()
                                        Text("The Guitar")
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical)
                                    HStack{
                                        Text("01")
                                            .foregroundColor(Color( red: 235, green: 235, blue: 245, opacity: 0.6))
                                       LockCircle()
                                        Text("The Guitar")
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical)
                                    HStack{
                                        Text("01")
                                            .foregroundColor(Color( red: 235, green: 235, blue: 245, opacity: 0.6))
                                       LockCircle()
                                        Text("The Guitar")
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical)
                                    HStack{
                                        Text("01")
                                            .foregroundColor(Color( red: 235, green: 235, blue: 245, opacity: 0.6))
                                       LockCircle()
                                        Text("The Guitar")
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical)
                                    HStack{
                                        Text("01")
                                            .foregroundColor(Color( red: 235, green: 235, blue: 245, opacity: 0.6))
                                       LockCircle()
                                        Text("The Guitar")
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical)
                                }
                                
                            }
                            .padding(.horizontal)

                        }
                        .frame(maxWidth: .infinity, maxHeight: geometry.size.height / 2.5, alignment: .topLeading)
                        .background(Color( red: 33/255, green: 40/255, blue: 63/255, opacity: 1.0))
                        .cornerRadius(16.0)
                        VStack(alignment: .leading){
                            Text("Featured On")
                                .foregroundColor(.white)
                                .font(.headline)
                            ScrollView(.horizontal){
                                HStack(spacing: 15) {
                                    AlbumView(albumName: "Chill-hop", albumQuantity: 7, albumType: "Instrumental")
                                        .frame(maxWidth: geometry.size.width / 2)
                                    AlbumView(albumName: "Chill-hop", albumQuantity: 7, albumType: "Instrumental")
                                        .frame(maxWidth: geometry.size.width / 2)
                                    AlbumView(albumName: "Chill-hop", albumQuantity: 7, albumType: "Instrumental")
                                        .frame(maxWidth: geometry.size.width / 2)
                                }
                            }
                        }
                        
                        
                    }
                    .padding()
                }
            }
            
        }
        
    }
}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView()
    }
}
