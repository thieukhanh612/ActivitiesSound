//
//  LaunchScreenView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/3/21.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Image("LaunchScreenImage")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea()
                VStack{
                    Spacer()
                    Text("MOOD SOUND")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .offset(CGSize(width: 0, height: -120.0))
                    Spacer()
                    Button(action: {}, label: {
                        Text("Get Started")
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                            .padding()
                    })
                    .frame(minWidth: geometry.size.width / 1.2)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color( red: 49/255, green: 129/255, blue: 147/255, opacity: 1), Color( red: 0, green: 255/255, blue: 245/255, opacity: 1)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                    )
                    .cornerRadius(10.0)
                    .offset(CGSize(width: 0 , height: -100.0))
                    HStack{
                        Text("Have an account?")
                            .foregroundColor(Color( red: 114/255, green: 128/255, blue: 157/255, opacity: 1))
                            .font(.subheadline)
                        Text("Login")
                            .foregroundColor(Color( red: 72/255, green: 227/255, blue: 255/255, opacity: 1))
                            .font(.subheadline)
                    }
                    .offset(CGSize(width: 0, height: -50.0))
                    
                }
                .padding()
                
            }
            .ignoresSafeArea()
        }
        
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
