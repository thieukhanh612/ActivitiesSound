//
//  Home.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 31/10/2021.
//

import SwiftUI

struct Home: View{
    @State var showTabBar = false
    @ObservedObject var model: LoginViewModel
    @ObservedObject var playerViewModel: PlayerViewModel
    var body: some View {
        ZStack{
            Color("BackgroundDefaultColor")
                .ignoresSafeArea()
            if model.isloggedIn{
                
                if showTabBar{
                    TabBar(model: model, playerViewModel: playerViewModel)
                } else{
                    ChooseActivityView(showTabbar: $showTabBar, playerViewModel: playerViewModel, model: model)
                }
            }
            else{
                LaunchScreenView(showTabBar: $showTabBar, model: model)
                
            }
        }
        .animation(.default)
        .onAppear{
            if model.isloggedIn{
                AuthManager.shared.refreshIfNeeded(completion: nil)
                print(UserDefaults.standard.value(forKey: "expirationDate"))
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(model: LoginViewModel(), playerViewModel:PlayerViewModel())
    }
}
