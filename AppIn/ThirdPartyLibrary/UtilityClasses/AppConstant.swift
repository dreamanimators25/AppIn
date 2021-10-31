//
//  AppConstant.swift
//  AppIn
//
//  Created by sameer khan on 19/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

let apdel = UIApplication.shared.delegate as! AppDelegate

let AppThemeColor = #colorLiteral(red: 0.261883378, green: 0.2925514281, blue: 0.7345846295, alpha: 1)
let btnCornerRadius = CGFloat(5.0)
let contentCornerRadius = CGFloat(5.0)

//let newBaseURL = "http://104.42.144.12:5000/api/"  // Live Server Url
//let newBaseURL = "http://40.112.131.121:5000/api/" // Test Server Url

//let kBaseURL = "https://dreamanimators.com/AppIn/api/v1/api.php?rquest=" // OLD
//let kBaseURL = "http://40.112.131.121/AppInWeb/api/v1/api.php?rquest=" // NEW

/*
let kLoginURL = kBaseURL + "login"                                    // DONE
let kRegisterURL = kBaseURL + "register"                               // DONE
let kChangePasswordURL = kBaseURL + "changePassword"                     // DONE
let kGetMyChannelsURL = kBaseURL + "getMyChannels"                       // DONE
let kGetMyProfileURL = kBaseURL + "getMyProfile"                         // DONE
let kEditProfileURL = kBaseURL + "editProfile"                           // DONE
let kGetChannelInfoURL = kBaseURL + "getChannelInfo"                      // 
let kGetBrandInfoURL = kBaseURL + "getBrandInfo"                         //
let kGetAllNotificationURL = kBaseURL + "getAllNotification"               // DONE
let kUpdateNotificationURL = kBaseURL + "updateNotification"               // DONE
let kViewContentURL = kBaseURL + "viewContent"                           // DONE
let kShareContentURL = kBaseURL + "shareContent"                         // DONE
let kRemoveChannelURL = kBaseURL + "removeChannel"                       // DONE
let kUpdateChannelNotificationURL = kBaseURL + "updateChannelNotification"  // Need to Test
let kChangeProfilePictureURL = kBaseURL + "changeProfilePicture"           // DONE
let kAddChannelWithCodeURL = kBaseURL + "addChannelWithCode"              // DONE
let kForgetPasswordURL = kBaseURL + "forgetPassword"                     // DONE
let kInviteUsersURL = kBaseURL + "inviteUsers"                          // DONE
let kGetPageURL = kBaseURL + "getPage"                                 //
let kGetContentsURL = kBaseURL + "getContents"                          //
let kGetAllChannelsURL = kBaseURL + "getAllChannels"                    // DONE
let kGetFeaturedChannelURL = kBaseURL + "getFeaturedChannel"             //
let kGetAllChannelsOver21 = kBaseURL + "getAllChannelsOver21"           //
let kDeleteMyAccount = kBaseURL + "deleteMyAccount"           // DONE
let kUpdateOver21 = kBaseURL + "UpdateOver21"           // DONE
*/


//let kBaseURL = "http://dreamanimators.com/AppIn/api/v2/" // NEW Url For Security Purpose
//let kBaseURL = "http://40.112.131.121/AppInWeb/api/v2/" // NEW Url For Security Purpose
let kBaseURL = "https://appin.se/api/v2/"
let kContentURL = "https://appin.se/api/"


// Controller - Auth
let kLoginURL = kBaseURL + "Auth/Login"
let kRegisterURL = kBaseURL + "Auth/Register"
let kChangePasswordURL = kBaseURL + "Auth/ChangePassword"
let kForgetPasswordURL = kBaseURL + "Auth/ForgetPassword"
let kVerifyEmail = kBaseURL + "Auth/VerifyEmail"
let kResendEmail = kBaseURL + "Auth/ResendEmail"

// Controller - User
let kGetUserURL = kBaseURL + "User/GetUser"
let kEditProfileURL = kBaseURL + "User/EditUser"
let kChangeProfilePictureURL = kBaseURL + "User/ChangeProfilePicture"
let kDeleteMyAccount = kBaseURL + "User/DeleteAccount"
let kUpdateOver21 = kBaseURL + "User/UpdateOver21"

// Controller - Notification
let kGetAllNotificationURL = kBaseURL + "Notification/GetNotifications"
let kUpdateNotificationURL = kBaseURL + "Notification/UpdateNotification"
let kUpdateChannelNotificationURL = kBaseURL + "Notification/UpdateChannelNotification"

// Controller - Channel
let kGetChannelsFeedURL = kBaseURL + "Channel/GetChannelsFeed"
let kGetChannelsURL = kBaseURL + "Channel/GetChannels"
let kGetMyChannelsURL = kBaseURL + "Channel/GetMyChannels"
let kGetFeaturedChannelURL = kBaseURL + "Channel/GetFeaturedChannels"
let kAddChannelWithCodeURL = kBaseURL + "Channel/AddChannelWithCode"
let kSearchChannel = "Channel/SearchChannel"
let kGetChannelInfoURL = kBaseURL + "Channel/GetChannelInfo"
let kGetBrandInfoURL = kBaseURL + "Channel/GetBrandInfo"
let kGetPageURL = kBaseURL + "Channel/GetPageInfo"
let kViewContentURL = kBaseURL + "Channel/ViewContent"
let kShareContentURL = kBaseURL + "Channel/ShareContent"
let kInviteUsersURL = kBaseURL + "Channel/InviteUsers"

let kRemoveChannelURL = kBaseURL + "Channel/RemoveChannel"

// Not Used
//let kGetMyProfileURL = kBaseURL + "getMyProfile"
//let kGetContentsURL = kBaseURL + "getContents"
//let kGetAllChannelsURL = kBaseURL + "getAllChannels"
//let kGetAllChannelsOver21 = kBaseURL + "getAllChannelsOver21"


