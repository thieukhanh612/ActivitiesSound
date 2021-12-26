//
//  SearchView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 19/11/2021.
//

import SwiftUI


struct SearchView: View {
    @State var searchText: String = ""
    var gridItemLayout = Array(repeating: GridItem(.flexible()), count: 2)
    @State var categories: [Category] = []
    @State var result: [SearchResult] = []
    @ObservedObject var playerViewModel: PlayerViewModel
    @State var isFetch: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundDefaultColor")
                    .ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Search")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("TextColor"))
                        SearchBar(text: $searchText, result: $result)
                        if result.isEmpty {
                            LazyVGrid(columns: gridItemLayout, spacing: 20){
                                ForEach(0 ..< categories.count,id: \.self){ value in
                                    NavigationLink(destination: {
                                        CategoryPlaylistView(playerViewModel: playerViewModel, category: categories[value])
                                    }) {
                                        CategoryView(category: categories[value])
                                    }
                                    
                                }
                            }
                        }
                        else{
                            let artist = result.filter({
                                switch $0{
                                case .artist: return true
                                default: return false
                                }
                            })
                            let album = result.filter({
                                switch $0 {
                                case .album: return true
                                default: return false
                                }
                            })
                            let track = result.filter({
                                switch $0{
                                case .track: return true
                                default: return false
                                }
                            })
                            let playlist = result.filter({
                                switch $0{
                                case .playlist: return true
                                default: return false
                                }
                            })
                            SectionView(title: "artist", result: artist, playerViewModel:playerViewModel)
                            SectionView(title: "album", result: album, playerViewModel: playerViewModel)
                            SectionView(title: "track", result: track, playerViewModel:playerViewModel)
                            SectionView(title: "playlist", result: playlist, playerViewModel:playerViewModel)
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
            .onAppear(perform: {
                if !isFetch{
                APICaller.shared.getCategory{[self] result in
                    DispatchQueue.main.async {
                        switch result{
                        case .success(let categories):
                            self.categories = categories
                            self.isFetch = true
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
                }
            })
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
        .navigationTitle("")
    }
}
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(playerViewModel: PlayerViewModel())
    }
}
struct CategoryView: View{
    let colors: [Color] = [
        .green,
        .blue,
        .orange,
        .pink,
        .purple,
        .gray,
        .red,
        .yellow
    ]
    
    var category: Category
    var body: some View{
        ZStack{
            VStack{
                HStack(alignment: .top){
                    Spacer()
                    if #available(iOS 15.0, *) {
                        AsyncImage(url:  URL(string: category.icons.first?.url ?? "")){ image in
                            image.resizable()
                        } placeholder: {
                            
                            Image(systemName: "personal")
                            
                        }
                        .frame(width: 60 , height: 60)
                        .padding()
                        .padding(.top, 5)
                        
                    } else {
                        // Fallback on earlier versions
                    }
                }
                Spacer()
                HStack{
                    Text(category.name)
                        .foregroundColor(Color("TextColor"))
                        .font(.title3)
                        .bold()
                        .padding()
                    Spacer()
                }
            }
            .frame(width: UIScreen.main.bounds.width/2 - 20 , height: 130 )
            .background( RoundedRectangle(cornerRadius: 10)
                            .frame(width: UIScreen.main.bounds.width/2 - 20 , height: 130 )
                            .foregroundColor(colors.randomElement()))
        }
    }
}
struct SearchBar: View{
    @Binding var text: String
    @State private var isEditing = false
    @Binding var result : [SearchResult]
    var body: some View{
        HStack {
            TextField("Songs, Playlists, Albums.........", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color.gray)
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    APICaller.shared.search(with: text){ result in
                        DispatchQueue.main.async {
                            switch result{
                            case .success(let result):
                                self.result = result
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                        
                    }
                }) {
                    Text("Search")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
            if !isEditing && !text.isEmpty {
                Button(action: {
                    self.text = ""
                    self.isEditing = false
                    self.result = []
                    
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
        .overlay(
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
                    .padding(.horizontal, 5)
            }
        )
        
    }
}
struct SectionView: View{
    var title: String
    var result: [SearchResult]
    @ObservedObject var playerViewModel: PlayerViewModel
    var body: some View{
        VStack(alignment: .leading){
            Text(title)
                .foregroundColor(Color("TextColor"))
                .font(.title3)
                .bold()
            ForEach( 0 ..< result.count, id: \.self){ value in
                switch result[value]{
                case .track(model: let track):
                    Button(action: {
                        PlaybackPresenter.shared.playerQueue?.pause()
                        PlaybackPresenter.shared.startPlayback(track: track)
                        playerViewModel.currentTrack = track
                        if playerViewModel.currentTrack?.preview_url != nil{
                            playerViewModel.showPlayer = true
                        }
                    }) {
                        HStack{
                            if #available(iOS 15.0, *) {
                                AsyncImage(url: URL(string: track.album?.images.first?.url ?? "")){ image in
                                    image.resizable()
                                } placeholder: {
                                    
                                    Image(systemName: "personal")
                                    
                                }
                                .frame(width: 50 , height: 50)
                                
                            } else {
                                // Fallback on earlier versions
                            }
                            VStack(alignment: .leading){
                                Text(track.name)
                                    .foregroundColor(Color("TextColor"))
                                    .font(.footnote)
                                    .padding(.top, 10)
                                Spacer()
                                Text(track.artists.first?.name ?? "")
                                    .font(.footnote)
                                    .foregroundColor(Color("SubTextColor"))
                                    .padding(.bottom, 10)
                            }
                            Spacer()
                            Image(systemName:"chevron.compact.right")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.gray)
                                .padding()
                        }
                        .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                        
                    }
                    
                case .playlist(model: let playlist):
                    NavigationLink(destination: PlaylistDetailView(playlist: playlist, playerViewModel:playerViewModel)) {
                        HStack{
                            if #available(iOS 15.0, *) {
                                AsyncImage(url: URL(string: playlist.images.first?.url ?? "")){ image in
                                    image.resizable()
                                } placeholder: {
                                    
                                    Image(systemName: "personal")
                                    
                                }
                                .frame(width: 50 , height: 50)
                                
                            } else {
                                // Fallback on earlier versions
                            }
                            VStack(alignment: .leading){
                                Text(playlist.name)
                                    .foregroundColor(Color("TextColor"))
                                    .font(.footnote)
                                    .padding(.top, 10)
                                Spacer()
                                Text(playlist.owner.display_name)
                                    .font(.footnote)
                                    .foregroundColor(Color("SubTextColor"))
                                    .padding(.bottom, 10)
                            }
                            Spacer()
                            Image(systemName:"chevron.compact.right")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.gray)
                                .padding()
                        }
                        .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                    }
                case .album(model: let album):
                    NavigationLink(destination: AlbumDetailView(album: album, playerViewModel:playerViewModel)) {
                        HStack{
                            if #available(iOS 15.0, *) {
                                AsyncImage(url: URL(string: album.images.first?.url ?? "")){ image in
                                    image.resizable()
                                } placeholder: {
                                    
                                    Image(systemName: "personal")
                                    
                                }
                                .frame(width: 50 , height: 50)
                                
                            } else {
                                // Fallback on earlier versions
                            }
                            VStack(alignment: .leading){
                                Text(album.name)
                                    .foregroundColor(Color("TextColor"))
                                    .font(.footnote)
                                    .padding(.top, 10)
                                Spacer()
                                Text(album.artists.first?.name ?? "")
                                    .font(.footnote)
                                    .foregroundColor(Color("SubTextColor"))
                                    .padding(.bottom, 10)
                            }
                            Spacer()
                            Image(systemName:"chevron.compact.right")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color("SubTextColor"))
                                .padding()
                        }
                        .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                    }

                case .artist(model: let artist):
                    Button(action:{
                        if let url = URL(string: artist.external_urls["spotify"] ?? ""){
                            UIApplication.shared.open(url)
                        }
                    }){
                        HStack{
                            if #available(iOS 15.0, *) {
                                AsyncImage(url: URL(string: artist.images?.first?.url ?? "")){ image in
                                    image.resizable()
                                } placeholder: {
                                    
                                    Image(systemName: "personal")
                                    
                                }
                                .frame(width: 50 , height: 50)
                                .clipShape(Circle())
                                
                            } else {
                                // Fallback on earlier versions
                            }
                            Text(artist.name)
                                .foregroundColor(Color("TextColor"))
                                .font(.footnote)
                                .padding(.top, 10)
                            
                            Spacer()
                            Image(systemName:"chevron.compact.right")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color("SubTextColor"))
                                .padding()
                        }
                        .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                    }

                }
            }
        }
    }
}

