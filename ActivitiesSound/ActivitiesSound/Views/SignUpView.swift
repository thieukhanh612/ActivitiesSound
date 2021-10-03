//
//  SignInView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/4/21.
//

import SwiftUI

struct SignUpView: View {
    @State var email: String
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Color(red: 40/255, green: 51/255, blue: 63/255)
                
                VStack {
                    ZStack {
                        Image("SignInImage")
                            .resizable()
                            .frame( width: .infinity, height:  geometry.size.width)
                            .overlay(Color(red: 0, green: 0, blue: 0, opacity: 0.5))
                        VStack(alignment: .leading, spacing: 8.0){
                            Text("Sign up")
                                .foregroundColor(.white)
                                .font(.title)
                                .bold()
                            Text("Welcome to Tunify, which will make accompany your mood for music. Let’s create account now")
                                .foregroundColor(.white)
                                .font(.subheadline)
                        }
                        .frame(maxWidth: geometry.size.width * 0.86)
                        .offset(CGSize(width: -12, height: 80.0))
                        
                    }
                    ZStack{
                        Rectangle()
                            .fill(Color(red: 40/255, green: 51/255, blue: 63/255))
                            .border(width: 3, edges: [.top], color: Color.purple)
                            .cornerRadius(radius: 30.0, corners: [.topLeft, .topRight])
                            .ignoresSafeArea()
                        VStack(spacing: 24){                            ScrollView {
                                
                                VStack(spacing: 24) {
                                    Spacer()
                                    VStack(alignment: .leading){
                                        Text("Full name")
                                            .foregroundColor(.white.opacity(0.48))
                                            .font(.caption)
                                        TextField("email", text: $email)
                                            .foregroundColor(.white)
                                            .font(.footnote)
                                    }
                                    .padding()
                                    .background(Color(red: 49/255, green: 62/255, blue: 85/255, opacity: 0.78))
                                    .cornerRadius(8.0)
                                    
                                    VStack(alignment: .leading){
                                        Text("Email Address")
                                            .foregroundColor(.white.opacity(0.48))
                                            .font(.caption)
                                        TextField("email", text: $email)
                                            .foregroundColor(.white)
                                            .font(.footnote)
                                    }
                                    .padding()
                                    .background(Color(red: 49/255, green: 62/255, blue: 85/255, opacity: 0.78))
                                    .cornerRadius(8.0)
                                    
                                    VStack(alignment: .leading){
                                        Text("Password")
                                            .foregroundColor(.white.opacity(0.48))
                                            .font(.caption)
                                        TextField("email", text: $email)
                                            .foregroundColor(.white)
                                            .font(.footnote)
                                    }
                                    .padding()
                                    .background(Color(red: 49/255, green: 62/255, blue: 85/255, opacity: 0.78))
                                    .cornerRadius(8.0)
                                    Spacer()
                                    VStack(spacing: 12){
                                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                            Text("Sign up")
                                                .foregroundColor(.white)
                                                .font(.footnote)
                                                .fontWeight(.semibold)
                                        })
                                        .frame(minWidth: geometry.size.width * 0.86)
                                        .padding()
                                        .background(Color(red: 123/255, green: 80/255, blue: 243/255))
                                        .cornerRadius(6.0)
                                        HStack{
                                            Text("You have account?")
                                                .foregroundColor(.white)
                                                .font(.footnote)
                                                .fontWeight(.semibold)
                                            
                                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                                Text("Sign in")
                                                    .foregroundColor(Color(red: 171/255, green: 144/255, blue: 250/255))
                                                    .font(.footnote)
                                                    .fontWeight(.semibold)
                                            })
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    .frame(width: geometry.size.width)
                    .offset(x: 0, y: -40)
                }
            }
            .ignoresSafeArea()
        }
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(email: "thieukhanh612@gmail.com")
    }
}
