//
//  PlayCircle.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/1/21.
//

import SwiftUI

struct CustomCircleView: View {
    var body: some View {
        VStack{
            PlayCircle()
        }
    }
}
struct PlayCircle: View{
    var body: some View{
        ZStack{
            Circle()
                .opacity(0.5)
                .frame(width: 32, height: 32, alignment: .center)
            Image(systemName: "play.fill")
                .foregroundColor(.white)
            
        }
    }
}
struct LockCircle: View{
    var body: some View{
        ZStack{
            Circle()
                .foregroundColor(Color("BackgroundDefaultColor"))
                .frame(width: 32, height: 32, alignment: .center)
            Image(systemName: "lock.fill")
                .foregroundColor(.white)
        }
    }
}
struct CustomCircleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            CustomCircleView()
            LockCircle()
        }
    }
}
