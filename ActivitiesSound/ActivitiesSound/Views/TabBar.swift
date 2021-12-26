//
//  TabBar.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/5/21.
//

import SwiftUI



struct TabBar: View {
    @State var current = 1
    @State var expand = true
    @ObservedObject var model: LoginViewModel
    @ObservedObject var playerViewModel: PlayerViewModel
    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $current,
                    content:  {
                DiscoverView(playerViewModel: playerViewModel)
                    .tabItem {
                        VStack(spacing: 6){
                            Image(systemName: "moon.zzz.fill")
                            
                            Text("Discover")
                            
                        }
                    }
                    .tag(1)
                    .navigationBarTitleDisplayMode(.inline)
                    .transition(.slide)
                SearchView(playerViewModel: playerViewModel)
                    .tabItem{
                        VStack(spacing: 6){
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    }
                    .tag(2)
                    .navigationBarTitleDisplayMode(.inline)
                    .transition(.slide)
                SettingViews(model: model, playerViewModel: playerViewModel)
                    .tabItem {
                        VStack{
                            Image(systemName: "person.fill")
                            Text("Profile")
                        }
                    }
                    .tag(3)
                    .navigationBarTitleDisplayMode(.inline)
                    .transition(.slide)
            })
                .navigationBarHidden(true)
                .accentColor(Color(red: 72/255, green: 112/255, blue: 255/255))
                .onAppear(){
                    UITabBar.appearance().barTintColor = UIColor.init(named: "BackgroundDefaultColor")
                    
                }
                .animation(.default)
            if playerViewModel.showPlayer{
                PlayerView(expand: $expand, playerViewModel: playerViewModel)
            }
        }

           .navigationBarHidden(true)

    }
    
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(model: LoginViewModel(), playerViewModel: PlayerViewModel())
    }
}
