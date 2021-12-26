//
//  UserLibrary.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 22/12/2021.
//

import SwiftUI

struct UserLibrary: View {
    
    @State var isPlaylistSelected: Bool = true
    @State var playlists: [Playlist] = []
    @State var albums: [Album] = []
    @State var albumCellViewModel: [NewReleasesCellViewModel] = []
    @State var playlistCellViewModel: [FeaturedPlaylistCellViewModel] = []
    @State var showAlert: Bool = false
    @State var nameOfNewPlaylist: String = ""
    @State var success: Bool = false
    @State var isShowingSheet: Bool = false
    
    @ObservedObject var playerViewModel: PlayerViewModel
    
    var gridItemLayout = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        
        ZStack{
            Color("BackgroundDefaultColor")
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20){
                Text("Music")
                    .foregroundColor(Color("TextColor"))
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal, 20)
                HStack(spacing: 20){
                    Button(action:{
                        isPlaylistSelected = true
                    }){
                        Text("Playlists")
                            .foregroundColor(isPlaylistSelected ? Color.blue : Color("TextColor"))
                            .font(.system(size: 18.0))
                    }
                    Button(action:{
                        isPlaylistSelected = false
                    }){
                        Text("Albums")
                            .foregroundColor(isPlaylistSelected ? Color("TextColor"): Color.blue )
                            .font(.system(size: 18.0))
                    }
                }
                .padding(.horizontal, 15)
                ScrollView{
                    
                    if isPlaylistSelected{
                        if playlists.count != 0 {
                            LazyVGrid(columns: gridItemLayout, spacing: 10){
                                ForEach(0 ..< playlists.count,id: \.self){ value in
                                    NavigationLink(destination: {
                                        PlaylistDetailView(playlist: playlists[value], playerViewModel: playerViewModel, isUserPlaylist: true)
                                    }) {
                                        UserPlaylistView(playlist: playlists[value])
                                    }
                                }
                                ZStack{
                                    Button(action:{
                                        isShowingSheet = true
                                    }){
                                        Image(systemName: "plus")
                                            .resizable()
                                            .foregroundColor(Color("TextColor"))
                                            .frame(width: 20, height: 20)
                                        }
                                        .frame(width: 50, height: 50)
                                        .border(Color("TextColor"), width: 2)
                                    }
                            }
                        }
                    } else{
                        if albums.count != 0 {
                            LazyVGrid(columns: gridItemLayout, spacing: 10){
                                ForEach(0 ..< albums.count, id: \.self){ value in
                                    NavigationLink(destination:{
                                        AlbumDetailView(album: albums[value], playerViewModel: playerViewModel)
                                    }){
                                        UserAlbumView(album: albums[value])
                                    }
                                }
                                

                            }
                        }
                    }
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .padding(.horizontal, 20)
        }
        .onAppear(perform: {
            fetchData()
        })
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .principal, content: {
                Text("Library")
                    .foregroundColor(Color("TextColor"))
                    .bold()
            })
        })
        .sheet(isPresented: $isShowingSheet, onDismiss: {}){
            AddNewPlaylistView(isShowingSheet: $isShowingSheet, success: $success, playlist: $playlists)
        }
    }
    func fetchData(){
        APICaller.shared.getCurrentUserPlaylist{ result in
            switch result{
            case.success(let model):
                self.playlists = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        APICaller.shared.getCurrentUserAlbums{ result in
            switch result{
            case.success(let model):
                self.albums = model
                self.albumCellViewModel = albums.compactMap({
                    return NewReleasesCellViewModel(name: $0.name, artworkURL: URL(string: $0.images.first?.url ?? ""), numberOfTracks: $0.total_tracks, artistName: $0.artists.first?.name ?? "")
                })
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
struct UserPlaylistView: View {
    var playlist: Playlist
    var body: some View {
        VStack(spacing: 10){
            if #available(iOS 15.0, *) {
                AsyncImage(url:  URL(string: playlist.images.first?.url ?? "")){ image in
                    image.resizable()
                } placeholder: {
                    
                    Image(systemName: "personal")
                    
                }
                .cornerRadius(10)
                .frame(width: 100 , height: 100)
                
            } else {
                // Fallback on earlier versions
            }
            
            Text(playlist.name)
                .font(.body)
                .foregroundColor(Color("TextColor"))
                .multilineTextAlignment(.center)
            Text(playlist.owner.display_name)
                .foregroundColor(.gray)
        }
        .frame(width: 100, height: 180)
    }
}
struct UserAlbumView: View {
    var album: Album
    var body: some View {
        VStack(spacing: 10){
            if #available(iOS 15.0, *) {
                AsyncImage(url:  URL(string: album.images.first?.url ?? "")){ image in
                    image.resizable()
                } placeholder: {
                    
                    Image(systemName: "personal")
                    
                }
                .cornerRadius(10)
                .frame(width: 100 , height: 100)
                
            } else {
                // Fallback on earlier versions
            }
            
            Text(album.name)
                .font(.body)
                .foregroundColor(Color("TextColor"))
                .multilineTextAlignment(.center)
            Text(album.artists.first?.name ?? "")
                .foregroundColor(.gray)
        }
        .frame(width: 100, height: 180)
    }
}
struct AddNewPlaylistView: View{
    @State var name: String = ""
    @Binding var isShowingSheet: Bool
    @State var showAlert: Bool = false
    @Binding var success: Bool
    @Binding var playlist: [Playlist]
    var body: some View{
        ZStack{
            Color("BackgroundDefaultColor")
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20){
                Text("Add new playlist to your library")
                    .foregroundColor(Color("TextColor"))
                    .font(.system(size: 24))
                Text("Please enter your new playlist's name here:")
                    .foregroundColor(Color("TextColor"))
                    .font(.system(size: 18))
                TextField("Enter name of your new playlist here", text: $name)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color.gray)
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                HStack{
                    Spacer()
                    Button(action:{
                        isShowingSheet = false
      
                    }){
                        Text("Dismiss")
                            .foregroundColor(Color("TextColor"))
                    }
                    Spacer()
                    Button(action:{
                        APICaller.shared.createPlaylist(with: name){ result in
                            switch result{
                            case true:
                                APICaller.shared.getCurrentUserPlaylist{ result in
                                    switch result{
                                    case.success(let model):
                                        self.playlist = model
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                    }
                                }
                                showAlert = true
                                success = true
                                isShowingSheet = false
                            case false:
                                success = false
                                showAlert = true
                            }
                            
                        }
                    }){
                        Text("Create")
                            .foregroundColor( name != "" ? Color("TextColor") : Color.gray)
                    }
                    .disabled(name != "" ? false : true)
                    Spacer()
                }
                
            }.padding()
        }
        .alert(isPresented: $showAlert){
            Alert(
                title:Text( success ? "Successfully" : "Error"),
                message: Text(success ? "New playlist is added to your lirary successfully" : "Please try again"),
                dismissButton: .default(Text("Okay"), action: {
                    
                })
            )
            
        }
    }
}
