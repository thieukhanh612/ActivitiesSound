//
//  TabBar.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/5/21.
//

import SwiftUI

struct TabBar: View {
    @State var current = 1
    @State var expand = false
    init() {
        UITabBar.appearance().barTintColor = UIColor.init(named: "BackgroundDefaultColor")
        
    }
    var body: some View {
    ZStack(alignment: .bottom){
            
        TabView(selection: $current,
                content:  {
                    DiscoverView()
                        .tabItem {
                            VStack(spacing: 6){
                                Image(systemName: "moon.zzz.fill")

                                Text("Discover")
                                    
                            }
                        }
                        .tag(1)
                    UserProfileView()
                        .tabItem {
                            VStack{
                                Image(systemName: "person.fill")
                                Text("Profile")
                            }
                        }
                        .tag(2)
                })
            .accentColor(Color(red: 72/255, green: 112/255, blue: 255/255))
        PlayerView(expand: $expand)
    }
        
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
