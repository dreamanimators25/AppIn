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

//let newBaseURL = "http://104.42.144.12:5000/api/"  // Live Server Url
//let newBaseURL = "http://40.112.131.121:5000/api/" // Test Server Url

//let kBaseURL = "https://dreamanimators.com/AppIn/api/v1/api.php?rquest=" // OLD
let kBaseURL = "http://40.112.131.121/AppInWeb/api/v1/api.php?rquest=" // NEW

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


