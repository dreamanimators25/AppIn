//
//  AppConstant.swift
//  AppIn
//
//  Created by sameer khan on 19/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

let apdel = UIApplication.shared.delegate as! AppDelegate

let AppThemeColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.6784313725, alpha: 1)
let btnCornerRadius = CGFloat(5.0)
let contentCornerRadius = CGFloat(5.0)

//let newBaseURL = "http://104.42.144.12:5000/api/" // Live Server Url
//let newBaseURL = "http://40.112.131.121:5000/api/" // Test Server Url

let kBaseURL = "https://dreamanimators.com/AppIn/api/v1/api.php?rquest="

let kLoginURL = kBaseURL + "login"                                      // DONE
let kRegisterURL = kBaseURL + "register"                                // DONE
let kChangePasswordURL = kBaseURL + "changePassword"
let kGetMyChannelsURL = kBaseURL + "getMyChannels"
let kGetMyProfileURL = kBaseURL + "getMyProfile"
let kEditProfileURL = kBaseURL + "editProfile"
let kGetChannelInfoURL = kBaseURL + "getChannelInfo"
let kGetBrandInfoURL = kBaseURL + "getBrandInfo"
let kGetAllNotificationURL = kBaseURL + "getAllNotification"
let kUpdateNotificationURL = kBaseURL + "updateNotification"
let kViewContentURL = kBaseURL + "viewContent"
let kShareContentURL = kBaseURL + "shareContent"
let kRemoveChannelURL = kBaseURL + "removeChannel"
let kUpdateChannelNotificationURL = kBaseURL + "updateChannelNotification"
let kChangeProfilePictureURL = kBaseURL + "changeProfilePicture"
let kAddChannelWithCodeURL = kBaseURL + "addChannelWithCode"
let kForgetPasswordURL = kBaseURL + "forgetPassword"
let kInviteUsersURL = kBaseURL + "inviteUsers"
let kGetPageURL = kBaseURL + "getPage"
let kGetContentsURL = kBaseURL + "getContents"
let kGetAllChannelsURL = kBaseURL + "getAllChannels"
let kGetFeaturedChannelURL = kBaseURL + "getFeaturedChannel"


