//
//  SelectPlaylist.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 23/12/2021.
//

import SwiftUI

struct SelectPlaylist: View {
    
    @State var playlistSelected: Playlist = Playlist.init(description: "", external_urls: ["":""], id: "", images: [], name: "", owner: .init(display_name: "", external_urls: ["":""], id: ""))
    @State var playlists: [Playlist] = []
    @State var showAlert: Bool = false
    @State var message: String = ""
    
    var track: AudioTrack
    
    var gridItemLayout = Array(repeating: GridItem(.flexible()), count: 3)
    var body: some View {
        ZStack{
            Color("BackgroundDefaultColor")
                .ignoresSafeArea()
            VStack(spacing: 20){
                Text(message)
                    .foregroundColor(Color("TextColor"))
                    .font(.system(size: 18))
                ScrollView{
                    if playlists.count != 0 {
                        LazyVGrid(columns: gridItemLayout, spacing: 10){
                            ForEach(0 ..< playlists.count,id: \.self){ value in
                                
                                Button(action:{
                                    showAlert = true
                                    playlistSelected = playlists[value]
                                }){
                                    UserPlaylistView(playlist: playlists[value])
                                }
                            }
                        }
                    }
                }
                
            }
        }
        .onAppear(perform: {
            APICaller.shared.getCurrentUserPlaylist{ result in
                switch result{
                case.success(let model):
                    self.playlists = model
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        })
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .principal, content: {
                Text("Select one playlist")
                    .foregroundColor(Color("TextColor"))
                    .bold()
            })
        })
        .alert(isPresented: $showAlert){
            Alert(
                title:Text("Add to playlist"),
                message: Text("Do you want to add this \(track.name) to \(playlistSelected.name) ? "),
                primaryButton: .cancel(Text("Cancel"), action: {
                    showAlert = false
                    
                }),
                secondaryButton: .destructive(Text("Yes"), action: {
                    APICaller.shared.addTrackToPlaylist(track: track, playlist: playlistSelected){ result in
                        switch result{
                        case true:
                            message = ""
                        case false:
                            message = "Please try again"
                        }
                        
                    }
                    APICaller.shared.getCurrentUserPlaylist{ result in
                        switch result{
                        case.success(let model):
                            self.playlists = model
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    message = "\(track.name) is added to \(playlistSelected.name) successfuly"
                })
            )
            
        }
        
        
    }
}


