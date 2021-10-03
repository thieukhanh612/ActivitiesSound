//
//  LoginView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/3/21.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        GeometryReader { geometry in
            
            ZStack{
                Color(red: 32/255, green: 41/255, blue: 51/255)
                VStack(spacing: 24) {
                    ZStack{
                        Image("LoginBackgroundImage")
                            .resizable()
                            .frame(maxHeight: 3*geometry.size.height / 5 )
                            .ignoresSafeArea()
                            .overlay( LinearGradient(gradient: Gradient(colors: [Color( red: 32/255, green: 41/255, blue: 51/255, opacity: 0.32), Color( red: 32/255, green: 41/255, blue: 51/255, opacity: 1)]), startPoint: .top, endPoint: .bottom)
                                        .frame(maxHeight: 3*geometry.size.height / 5 )
                                        .ignoresSafeArea())
                        VStack(spacing: 24) {
                            Spacer()
                            Image("Icon")
                                .resizable()
                                .scaledToFit()
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .frame(maxWidth: 40, maxHeight: 40)
                            VStack(spacing: 16){
                                Text("Milions of Songs.\n Free on Tunify")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .scaledToFill()
                                Text("I can chase you and I can catch you, but there is \n nothing I can do to make you mine")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .scaledToFill()
                            }
                            .padding()
                            
                        }
                        .padding()
                        
                    }
                    .frame(maxHeight: geometry.size.height * 0.6)
                    .ignoresSafeArea()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Sign up free")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        
                    })
                    .padding()
                    .frame(maxWidth: geometry.size.width * 0.86)
                    .background(Color(red: 95/255, green: 25/255, blue: 242/255))
                    .cornerRadius(20.0)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        HStack(){
                            Image("googlelogo")
                                .resizable()
                                .frame(maxWidth: 24, maxHeight: 24)
                            Spacer()
                            Text("Continue with Google")
                                .font(.footnote)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: geometry.size
                                .width * 0.86, alignment: .leading)
                    })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        HStack(){
                            Image(systemName: "applelogo")
                                .resizable()
                                .foregroundColor(.white)
                                .scaledToFit()
                                .frame(maxWidth: 24, maxHeight: 24)
                            Spacer()
                            Text("Continue with Apple")
                                .font(.footnote)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: geometry.size
                                .width * 0.86, alignment: .leading)
                    })
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Login")
                            .foregroundColor(.white)
                            .font(.footnote)
                            .fontWeight(.semibold)
                    })
                    Spacer()
                }
            }
            .ignoresSafeArea()
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
