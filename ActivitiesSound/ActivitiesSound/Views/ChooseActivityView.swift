//
//  SwiftUIView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 26/12/2021.
//

import SwiftUI

struct ChooseActivityView: View {
    @State var showDropBox: Bool = false
    @State var showOptionRecommend: Bool = false
    @State var option: DropdownOption = DropdownOption(key: UUID().uuidString, value: "")
    @Binding var showTabbar: Bool
    
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var model: LoginViewModel
    
    var imageNames:[String] = ["Chillout", "Cooking","Housework", "Funmood", "Sad", "Studying", "Workout","Sleeping"]
    
    static var uniqueKey: String {
        UUID().uuidString
    }
    static let options: [DropdownOption] = [
        DropdownOption(key: uniqueKey, value: "Normal cooking"),
        DropdownOption(key: uniqueKey, value: "Making cake"),
        DropdownOption(key: uniqueKey, value: "Outside cooking"),
        DropdownOption(key: uniqueKey, value: "Workout"),
        DropdownOption(key: uniqueKey, value: "Walking"),
        DropdownOption(key: uniqueKey, value: "Skilled trades"),
        DropdownOption(key: uniqueKey, value: "Technical"),
        DropdownOption(key: uniqueKey, value: "Tatical games"),
        DropdownOption(key: uniqueKey, value: "Video games"),
        DropdownOption(key: uniqueKey, value: "Housework"),
        DropdownOption(key: uniqueKey, value: "Sleeping"),
        DropdownOption(key: uniqueKey, value: "Chillout"),
        DropdownOption(key: uniqueKey, value: "Fun mood"),
        DropdownOption(key: uniqueKey, value: "Sad mood"),
        DropdownOption(key: uniqueKey, value: "Dance")
    ]
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("BackgroundDefaultColor")
                    .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 20){
                    NavigationLink(destination: ActivityMusicRecommendResult(playerViewModel: playerViewModel, option: option), isActive: $showOptionRecommend){
                        EmptyView()
                    }
                    if !showDropBox{
                        AnimatedImage(imageNames: imageNames)
                            .padding()
                    }
                    Text("Hey, what are you doing?")
                        .foregroundColor(Color("TextColor"))
                        .font(.system(size: 24))
                        .bold()
                    Text("Let choose activity. We will find for you the best music you need !")
                        .foregroundColor(Color("TextColor"))
                        .font(.system(size: 18))
                    Group {
                        DropBox(
                            shouldShowDropdown: $showDropBox,
                            placeholder: "Choose what are you doing",
                            options: DiscoverView.options,
                            onOptionSelected: { option in
                                print(option)
                                self.option = option
                                showOptionRecommend = true
                                
                            }, playerViewModel: playerViewModel)
                            .padding(.horizontal)
                    }
                    if showDropBox{
                        VStack{
                            
                        }.frame(height:CGFloat(DiscoverView.options.count) * 30 )
                    }
                    HStack{
                        Spacer()
                        Button(action:{
                            showTabbar = true
                        }){
                            ZStack{
                                Text("Maybe later ->")
                                    .foregroundColor(Color("BackgroundDefaultColor"))
                                    .bold()
                                    .padding()
                            }
                            .background(Color("TextColor"))
                            .border(LinearGradient(colors: [Color.init(red: 0, green: 56, blue: 245),Color.init(red: 159, green: 3, blue: 255)], startPoint: .leading, endPoint: .trailing), width: 1)
                            .shadow(radius: 5)
                        }
                        Spacer()
                    }
                    .navigationBarHidden(true)
                    Spacer()
                    
                    
                }
                .navigationBarHidden(true)
                .animation(.default)
                .padding()
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }
}
struct AnimatedImage: View {
  @State private var image: Image?
  var imageNames: [String]

  var body: some View {
      ZStack {
          Group {
          image?
              .resizable()
              .scaledToFit()
      }
      }.onAppear(perform: {
          self.animate()
      })
  }
  
  func animate() {
    var imageIndex: Int = 0
      image = Image(imageNames[imageIndex])
      Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) {  timer in
      if imageIndex < self.imageNames.count {
        self.image = Image(self.imageNames[imageIndex])
        imageIndex += 1
          if imageIndex == imageNames.count{
              imageIndex = 0
          }
      }
      else {
        imageIndex = 0
      }
    }
  }
}
