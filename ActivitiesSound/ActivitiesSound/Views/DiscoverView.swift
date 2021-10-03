//
//  ContentView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/1/21.
//

import SwiftUI

struct DiscoverView: View {
    var body: some View {
        
        ZStack {
            Color("BackgroundDefaultColor")
                .ignoresSafeArea(.all)
            VStack(spacing: 8){
                VStack{
                    Text("Sleep")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                .frame( maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 140, alignment: .bottomLeading)
                .padding()
                ScrollView(.horizontal) {
                    HStack(spacing: 16){
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "circle.grid.3x3.fill")
                                .foregroundColor(.white)
                            Text("All")
                                .foregroundColor(.white)
                                .font(.headline)
                            
                        })
                        .padding(16)
                        .background(Color( red: 72/255, green: 112/255, blue: 255/255, opacity: 1))
                        .cornerRadius(24.0)
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "circle.grid.3x3.fill")
                                .foregroundColor(.white)
                            Text("Ambient")
                                .foregroundColor(.white)
                                .font(.headline)
                        })
                        .padding(16.0)
                        .background(Color( red: 33/255, green: 40/255, blue: 63/255, opacity: 1))
                        .cornerRadius(24.0)
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "circle.grid.3x3.fill")
                                .foregroundColor(.white)
                            Text("For Kids")
                                .foregroundColor(.white)
                                .font(.headline)
                        })
                        .padding(16)
                        .background(Color( red: 33/255, green: 40/255, blue: 63/255, opacity: 1))
                        .cornerRadius(24.0)
                        
                        
                    }
                }
                .padding()
                .scaledToFit()
                ScrollView{
                    VStack{
                        HStack(spacing: 15){
                            AlbumView(albumName: "Guitar Camp", albumQuantity: 7, albumType: "Instrumental",albumImageString: "Chillout")
                         
                            AlbumView(albumName: "Chill - hop", albumQuantity: 7, albumType: "Instrumental",albumImageString: "Cooking")
                     
                            
                        }
                    }
                    .padding()
                    VStack{
                        HStack(spacing: 15){
                            AlbumView(albumName: "Guitar Camp", albumQuantity: 7, albumType: "Instrumental",albumImageString: "Funmood")
                         
                            AlbumView(albumName: "Chill - hop", albumQuantity: 7, albumType: "Instrumental",albumImageString: "Sleeping")
                            
                            
                        }
                    }
                    .padding()
                    VStack{
                        HStack(spacing: 15){
                            AlbumView(albumName: "Guitar Camp", albumQuantity: 7, albumType: "Instrumental",albumImageString: "Studying")
                            AlbumView(albumName: "Chill - hop", albumQuantity: 7, albumType: "Instrumental",albumImageString: "Housework")
                            
                        }
                    }
                    .padding()
                    VStack{
                        HStack(spacing: 15){
                            AlbumView(albumName: "Guitar Camp", albumQuantity: 7, albumType: "Instrumental",albumImageString: "Workout")
                      
                            AlbumView(albumName: "Chill - hop", albumQuantity: 7, albumType: "Instrumental",albumImageString: "Sad")

                        }
                    }
                    .padding()
                }
                Spacer()
            }
            
        }
        .ignoresSafeArea()
        
        
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
