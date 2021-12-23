//
//  UserProfileView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 13/11/2021.
//

import SwiftUI

struct UserProfileView: View {
    @Binding var userProfile: UserProfile
    var body: some View {
        ZStack {
            ZStack{
                
                Color("BackgroundDefaultColor")
                    .ignoresSafeArea()
                VStack{
                    Text("Hello \(userProfile.display_name) 😀")
                        .foregroundColor(Color("TextColor"))
                        .font(.title)
                    if #available(iOS 15.0, *) {
                        AsyncImage(url: URL(string: userProfile.images.first?.url ?? "" )){ image in
                            image.resizable()
                        } placeholder: {
                            
                            Image(systemName: "personal")
                            
                        }
                        .frame(width: 120 , height: 120)
                        .clipShape(Circle())
                        .padding()
                    } else {
                        // Fallback on earlier versions
                    }
                    HStack{
                        VStack{
                            Divider()
                                .background(Color("TextColor"))
                                .padding(.horizontal,2)
                        }
                        Text("User profile")
                            .foregroundColor(Color("TextColor"))
                        VStack{
                            Divider()
                                .background(Color("TextColor"))
                                .padding(.horizontal,2)
                        }
                    }
                    VStack(alignment: .leading, spacing: 30) {
                        TitleView(title: "Personal information:")
                        VStack(alignment: .leading, spacing: 20) {
                            ContentView(content: "Country: \(userProfile.country)")
                            ContentView(content: "Email: \(userProfile.email)")
                        }
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 25, alignment: .leading)
                        .border(Color.secondary, width: 1.0)
                        .cornerRadius(7.0)
                        
                    }
                    VStack(alignment: .leading, spacing: 30) {
                        TitleView(title: "Account information:")
                        VStack(alignment: .leading, spacing: 20) {
                            ContentView(content: "User ID: \(userProfile.id)")
                            ContentView(content: "Plan: \(userProfile.product)")
                        }
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 25, alignment: .leading)
                        .border(Color.secondary, width: 1.0)
                        .cornerRadius(7.0)
                        
                    }
                    .padding(.top, 25)
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Profile")
                        .foregroundColor(Color("TextColor"))
                        .fontWeight(.bold)
                }
            }
            
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(userProfile: Binding.constant(UserProfile(country: "", display_name: "", email: "", explicit_content: ["":false], external_urls: ["": ""], id: "", product: "", images: [UserImage.init(url: "")])) )
    }
}

struct TitleView: View {
    let title: String
    var body: some View {
        Text(title)
            .foregroundColor(Color("TextColor"))
            .font(.title)
            .fontWeight(.bold)
    }
}

struct ContentView: View {
    let content: String
    var body: some View {
        Text(content)
            .foregroundColor(Color("TextColor"))
            .font(.body)
    }
}
