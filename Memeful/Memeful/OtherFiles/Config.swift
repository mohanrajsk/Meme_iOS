//
//  Config.swift
//  Memeful
//
//  Created by LKB-L-105 on 13/12/19.
//

import UIKit


// MARK: APIs
let CLIENT_ID = "?client_id=546c25a59c58ad7"
let GALLERY_API = "3/gallery/"
let MOST_VIRAL_POPUPAR_API = GALLERY_API + "hot/viral/%d" + CLIENT_ID
let MOST_VIRAL_RANDOM_API = GALLERY_API + "random/random/%d" + CLIENT_ID
let MOST_VIRAL_NEWEST_API = GALLERY_API + "hot/time/0" + CLIENT_ID
let USER_SUBMITTED_POPUPAR_API = GALLERY_API + "user/viral/%d" + CLIENT_ID
let USER_SUBMITTED_RISING_API =  GALLERY_API + "user/rising/%d" + CLIENT_ID
let USER_SUBMITTED_NEWEST_API =  GALLERY_API + "user/time/%d" + CLIENT_ID
let BEST_COMMENTS_API = "/3/gallery/%@/comments/best" + CLIENT_ID

// MARK: Messages
let parseError = "Cannot parse response"

// MARK: Constants
let EMAIL_MIN = 6
let EMAIL_MAX = 64

let PASSWORD_MIN = 8
let PASSWORD_MAX = 64

let LOGGED_IN = "LOGIN"
