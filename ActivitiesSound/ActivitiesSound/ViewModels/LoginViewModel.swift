//
//  LoginResponse.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 13/11/2021.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject{
    @Published var isloggedIn : Bool
    init(){
//        if AuthManager.shared.isSignedIn{
//            isloggedIn = true
//        }
//        else{
//            isloggedIn = false
//        }
        isloggedIn = false
    }
}
