//
//  PlayerView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/5/21.
//

import SwiftUI

struct PlayerView: View {
    @Binding var expand  : Bool
    @State var volume = PlaybackPresenter.shared.player?.volume ?? 0.5
    @ObservedObject var playerViewModel: PlayerViewModel
    var height = UIScreen.main.bounds.height / 3
    @State var offset : CGFloat = 0
    @State var isPlaying: Bool = true
    var body: some View {
        VStack {
            
            if expand {
                Spacer(minLength: 0)
                HStack {
                    Button(action:{
                        PlaybackPresenter.shared.playerQueue?.pause()
                        PlaybackPresenter.shared.playerQueue?.removeAllItems()
                        PlaybackPresenter.shared.player?.pause()
                        playerViewModel.showPlayer = false
                        expand = false
                    }){
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.white.opacity(0.5))
                            .padding()
                        
                    }
                    Spacer(minLength: 0)
                    Capsule()
                        .fill(Color.white.opacity(0.5))
                        .frame(width: 80, height: 4)
                        .padding()
                    Spacer()
                    Button(action: shareButton) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.white.opacity(0.5))
                            .padding()
                    }
                }
                Spacer()
            }
            HStack(spacing: 15){
                if expand {Spacer(minLength: 0)}
                if #available(iOS 15.0, *) {
                    AsyncImage(url:  URL(string: playerViewModel.currentTrack?.album?.images.first?.url ?? "https://yt3.ggpht.com/YwV4ZBGSttxt76LXxLABJdETHOQ7M4DT2ZOXv82xo85FXcZBd91X74uV-3KLeumhn-71_zFH=s900-c-k-c0x00ffffff-no-rj")){ image in
                        image.resizable()
                    } placeholder: {
                        
                        Image(systemName: "personal")
                        
                    }
                    .frame(width: expand ? height : 55, height:expand ? height : 55)
                    .cornerRadius(15)
                    
                } else {
                    // Fallback on earlier versions
                }
                if !expand {
                    Text(playerViewModel.currentTrack?.name ?? "")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                Spacer()
                if !expand {
                    if !isPlaying {
                        Button(action: {
                            PlaybackPresenter.shared.didTapPlayPause()
                            isPlaying = true
                        }, label: {
                            Image(systemName: "play.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                        })
                    }
                    else{
                        Button(action: {
                            PlaybackPresenter.shared.didTapPlayPause()
                            isPlaying = false
                        }, label: {
                            Image(systemName: "stop.fill")
                                .foregroundColor(.white)
                                .font(.title2)
                            
                        })
                    }
                    Button(action: {
                        PlaybackPresenter.shared.didTapForward()
                        playerViewModel.currentTrack = PlaybackPresenter.shared.currentTrack
                    }, label: {
                        Image(systemName: "forward.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                    })
                }
            }
            .padding(.horizontal)
            if expand{
                
                Text(playerViewModel.currentTrack?.name ?? "")
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                Text(playerViewModel.currentTrack?.artists.first?.name ?? "")
                    .foregroundColor(.gray)
                    .font(.title2)
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
                HStack{
                    Button(action: {
                        PlaybackPresenter.shared.didTapBackwards()
                        playerViewModel.currentTrack = PlaybackPresenter.shared.currentTrack
                    }, label: {
                        Image(systemName: "backward.fill")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding(.bottom, 50)
                            .padding(.horizontal, 20)
                    })
                    Spacer()
                    if !isPlaying {
                        Button(action: {
                            PlaybackPresenter.shared.didTapPlayPause()
                            isPlaying = true
                        }, label: {
                            Image(systemName: "play.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(.bottom, 50)

                        })
                    }
                    else{
                        Button(action: {
                            PlaybackPresenter.shared.didTapPlayPause()
                            
                            isPlaying = false
                        }, label: {
                            Image(systemName: "stop.fill")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .padding(.bottom, 50)
                        })
                    }
                    Spacer()
                    Button(action: {
                        PlaybackPresenter.shared.didTapForward()
                        playerViewModel.currentTrack = PlaybackPresenter.shared.currentTrack
                    }, label: {
                        Image(systemName: "forward.fill")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding(.bottom, 50)
                            .padding(.horizontal, 20)
                    })
                }
                Spacer()
                HStack{
                    Image(systemName: "speaker.fill")
                        .foregroundColor(.white)
                        .font(.body)
                    Slider(value: $volume, onEditingChanged: { _ in
                        PlaybackPresenter.shared.didSlideSlider(volume)
                    })
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
                Divider()
                    .background(Color.white)
            }
                .onTapGesture(perform: {
                    withAnimation(.spring()){
                        expand = true
                    }}))
        .cornerRadius(expand ? 20 : 0)
        .offset( y: expand ? 0 : -48)
        .offset(y: offset)
        .gesture(DragGesture().onEnded(onEnded(value:)).onChanged(onChanged(value:)))
        .onAppear{
            if ((PlaybackPresenter.shared.currentTrack?.preview_url?.isEmpty) == nil){
                playerViewModel.showPlayer = false
            }
            playerViewModel.currentTrack = PlaybackPresenter.shared.currentTrack
            
        }
        .ignoresSafeArea()
    }
    func onChanged(value: DragGesture.Value){
        if value.translation.height > 0 && expand{
            offset = value.translation.height
        }
    }
    func onEnded(value: DragGesture.Value){
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)){
            if value.translation.height > height{
                expand = false
            }
            offset = 0
        }
    }
    func shareButton(){
        
        let url = URL(string: PlaybackPresenter.shared.currentTrack?.external_urls["spotify"] ?? "")
        let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(expand: Binding.constant(true), playerViewModel: PlayerViewModel())
    }
}
