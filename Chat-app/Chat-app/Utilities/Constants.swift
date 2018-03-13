//
//  Constants.swift
//  Chat-app
//
//  Created by Mino RANDRIAMANIVO on 06/03/2018.
//  Copyright © 2018 Mino RANDRIAMANIVO. All rights reserved.
//

import Foundation

typealias CompletionHandler = ( _ Success:Bool ) -> ()
let BASE_URL = "https://chattychatmirado.herokuapp.com/v1/"
let URL_REGISTER  = "\(BASE_URL)account/register"
let URL_LOGIN  = "\(BASE_URL)account/login"
let URL_USER_ADD  = "\(BASE_URL)user/add"
let URL_FIND_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/" //user/byEmail
let URL_GET_CHANNELS = "\(BASE_URL)channel/"

let TO_LOGIN = "toLogin"
let TO_REGISTER = "toRegister"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "avatarPickerAccount"
let placeHolderColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 0.5)
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_MAIL = "userEmail"

//Header
  let HEADER = ["Content-Type" : "application/json; charset = utf-8"]
let BEARER_HEADER = [
    "Authorization" : "Bearer \(AuthService.instance.authToke)",
    "Content-Type" : "application/json; charset=utf-8"
]

//Notification
let NOTIF_DATA_USER_DID_CHANGE = Notification.Name("notifUserDidChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIF_CHANNELS_SELECTED = Notification.Name("channelSelected")
