//
//  LaunchScreenView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/3/21.
//

import SwiftUI
import Foundation

struct LaunchScreenView: View {
    @Binding var showTabBar: Bool
    @ObservedObject var model: LoginViewModel
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack{
                    Image("LaunchScreenImage")
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .ignoresSafeArea()
                    ButtonAndText(model: model, showTabBar: $showTabBar)
                    
                }
                .ignoresSafeArea()
                .navigationBarHidden(true)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView(showTabBar: Binding.constant(false), model: LoginViewModel())
    }
}

struct ButtonAndText: View {
    @ObservedObject var model: LoginViewModel
    @Binding var showTabBar: Bool
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center){
                Spacer()
                Button(action: {showTabBar.toggle()}, label: {
                    Text("Get Started")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                        .padding()
                })
                    .frame(minWidth: geometry.size.width / 1.2)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color( red: 255/255, green: 0/255, blue: 255/255, opacity: 1), Color( red: 1/255, green: 83/255, blue: 243/255, opacity: 1)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                    )
                    .cornerRadius(10.0)
                    .offset(CGSize(width: 0 , height: -100.0))
                HStack{
                    Spacer()
                    Text("Have an account?")
                        .foregroundColor(Color( red: 114/255, green: 128/255, blue: 157/255, opacity: 1))
                        .font(.subheadline)
                    NavigationLink(destination: LoginWebView(model: model)) {
                        Text("Login")
                            .foregroundColor(Color( red: 255/255, green: 0/255, blue: 255/255, opacity: 1))
                            .font(.subheadline)
                    }
                    Spacer()
                    
                    
                }
                .offset(CGSize(width: 0, height: -50.0))
                
            }
            .padding()
        }
    }
}
