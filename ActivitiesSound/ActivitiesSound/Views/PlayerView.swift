//
//  PlayerView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/5/21.
//

import SwiftUI

struct PlayerView: View {
    @Binding var expand  : Bool
    @State var volume = CGFloat(0)
    var height = UIScreen.main.bounds.height / 3
    var body: some View {
        VStack {
            
            if expand {
                Spacer(minLength: 0)
                Capsule()
                    .fill(Color.white.opacity(0.5))
                    .frame(width: 80, height: 4)
                    .padding()
                Spacer()
                
            }
            HStack(spacing: 15){
                if expand {Spacer(minLength: 0)}
                Image("AlbumImage_1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: expand ? height : 55, height:expand ? height : 55)
                    .cornerRadius(15)
                if !expand {
                    Text("Guitar Camp")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                Spacer()
                if !expand {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "play.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                    })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "forward.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                    })
                }
            }
            .padding(.horizontal)
            if expand{
                
                Text("Guitar Camp")
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                HStack{
                    Capsule()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.7), Color.white.opacity(0.1)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                        .frame(height: 4)
                    Text("Live")
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                    Capsule()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.1), Color.white.opacity(0.7)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                        .frame(height: 4)
                        
                }
                .padding()
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "stop.fill")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding(.bottom, 50)
                })
                Spacer()
                HStack{
                    Image(systemName: "speaker.fill")
                        .foregroundColor(.white)
                        .font(.body)
                    Slider(value: $volume)
                        .accentColor(.white)
                    Image(systemName: "speaker.wave.3.fill")
                        .foregroundColor(.white)
                        .font(.body)
                }
                .padding(.horizontal)
                Spacer()
                
            }
        }
        .frame(maxHeight: expand ? .infinity : 80)
        .background(
            VStack(spacing: 0) {
                BlurView()
                    .onTapGesture {
                        self.expand.toggle()
                    }
                Divider()
                    .background(Color.white)
            })
        .offset( y: expand ? 0 : -48)
        .ignoresSafeArea()
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(expand: Binding.constant(true))
    }
}
