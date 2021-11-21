//
//  UserProfileView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/2/21.
//

import SwiftUI

struct SettingViews: View {
    @ObservedObject var model: LoginViewModel
    @ObservedObject var playerViewModel: PlayerViewModel
    @State var showUserProfile: Bool = false
    @State var userProfile = UserProfile(country: "", display_name: "", email: "", explicit_content: ["":false], external_urls: ["": ""], id: "", product: "", images: [UserImage.init(url: "")])
    var body: some View {
        NavigationView {
            ZStack{
                    NavigationLink(isActive: $showUserProfile, destination:
                                    {UserProfileView(userProfile: $userProfile)}
                    , label: {
                        Text("Profile")
                    })
                    Color("BackgroundDefaultColor")
                        .ignoresSafeArea()
                    VStack{
                        Text("Settings")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .padding(.top, 40)
                            .padding(.bottom, 20)
                            .frame(width: UIScreen.main.bounds.width)
                            .background(Color.secondary)
                            .ignoresSafeArea()
                        UserProfileButton(optionText: "PROFILE", optionButtonText: "View Your Profile", showUserProfile: $showUserProfile, userProfile: $userProfile)
                            .padding()
                        SignOutButton(optionText: "ACCOUNT", optionButtonText: "Sign Out", model: model, playerViewModel: playerViewModel, showUserProfile: $showUserProfile, userProfile: $userProfile)
                            .padding(.top, 50)
                        Spacer()
                    }
                }
        }
        .navigationBarHidden(true)
        
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingViews(model: LoginViewModel(), playerViewModel: PlayerViewModel())
    }
}

struct UserProfileButton: View {
    let optionText: String
    let optionButtonText: String
    @Binding var showUserProfile: Bool
    @Binding var userProfile: UserProfile
    var body: some View {
        VStack(alignment: .leading){
            Text(optionText)
                .bold()
                .foregroundColor(.white)
                .padding(.horizontal, 25)
            Button(action: {
                APICaller.shared.getCurrentUserProfile{ [self] result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let model):
                            self.userProfile = model
                            showUserProfile = true
                            print(model)
                        case .failure(let error):
                            print(error.localizedDescription)
                            
                        }
                        
                    }
                }
            }, label: {
                Text(optionButtonText)
                    .foregroundColor(Color.white)
                    .font(.body)
                    .fontWeight(.bold)
                    .padding()
                    .frame(width:UIScreen.main.bounds.width, alignment: .leading )
                    .background(Color.secondary)
            })
        }
        
    }
}
struct SignOutButton: View {
    let optionText: String
    let optionButtonText: String
    @ObservedObject var model: LoginViewModel
    @ObservedObject var playerViewModel: PlayerViewModel
    @Binding var showUserProfile: Bool
    @Binding var userProfile: UserProfile
    @State var showAlert = false
    var body: some View {
        VStack(alignment: .leading){
            Text(optionText)
                .bold()
                .foregroundColor(.white)
                .padding(.horizontal, 25)
            Button(action: {
                showAlert.toggle()
                PlaybackPresenter.shared.player?.pause()
                playerViewModel.showPlayer = false
            }, label: {
                Text(optionButtonText)
                    .foregroundColor(Color.white)
                    .font(.body)
                    .fontWeight(.bold)
                    .padding()
                    .frame(width:UIScreen.main.bounds.width, alignment: .leading )
                    .background(Color.secondary)
            })
                .alert(isPresented: $showAlert){
                    Alert(
                        title:Text("Sign out"),
                        message: Text("Do you want to sign out?"),
                        primaryButton: .cancel(Text("Cancle"), action: {
                            showAlert = false
                            
                        }),
                        secondaryButton: .destructive(Text("Yes"), action: {
                            AuthManager.shared.signOut{[self] signedOut in
                                if signedOut{
                                    DispatchQueue.main.async {
                                        model.isloggedIn = false
                                    }
                                }
                            }
                        })
                    )
                    
                }
        }
        
    }
}
