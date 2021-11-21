//
//  ActivitiesSoundApp.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/1/21.
//

import SwiftUI
import CoreMedia

@main
struct ActivitiesSoundApp: App {
    @ObservedObject var model = LoginViewModel()
    @ObservedObject var playerViewModel = PlayerViewModel()
    var body: some Scene {
        WindowGroup {
           Home(model: model, playerViewModel: playerViewModel)
        }
    }
}
