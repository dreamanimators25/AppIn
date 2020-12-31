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

let kBaseURL = "https://dreamanimators.com/AppIn/api/v1/api.php?rquest="

let kLoginURL = kBaseURL + "login"                                          // DONE
let kRegisterURL = kBaseURL + "register"                                    // DONE
let kChangePasswordURL = kBaseURL + "changePassword"                        // DONE
let kGetMyChannelsURL = kBaseURL + "getMyChannels"                          // PARTIAL DONE
let kGetMyProfileURL = kBaseURL + "getMyProfile"                            // PARTIAL DONE
let kEditProfileURL = kBaseURL + "editProfile"                              // DONE
let kGetChannelInfoURL = kBaseURL + "getChannelInfo"                        //
let kGetBrandInfoURL = kBaseURL + "getBrandInfo"                            // Not used
let kGetAllNotificationURL = kBaseURL + "getAllNotification"                // PARTIAL DONE
let kUpdateNotificationURL = kBaseURL + "updateNotification"                // DONE
let kViewContentURL = kBaseURL + "viewContent"                              //
let kShareContentURL = kBaseURL + "shareContent"                            //
let kRemoveChannelURL = kBaseURL + "removeChannel"                          //
let kUpdateChannelNotificationURL = kBaseURL + "updateChannelNotification"  //
let kChangeProfilePictureURL = kBaseURL + "changeProfilePicture"            // DONE
let kAddChannelWithCodeURL = kBaseURL + "addChannelWithCode"                // PARTIAL DONE
let kForgetPasswordURL = kBaseURL + "forgetPassword"                        // DONE
let kInviteUsersURL = kBaseURL + "inviteUsers"                              // NOT WORKING
let kGetPageURL = kBaseURL + "getPage"                                      // Not used
let kGetContentsURL = kBaseURL + "getContents"                              // Not used
let kGetAllChannelsURL = kBaseURL + "getAllChannels"                        // PARTIAL DONE
let kGetFeaturedChannelURL = kBaseURL + "getFeaturedChannel"                // Not used
let kGetAllChannelsOver21 = kBaseURL + "getAllChannelsOver21"               // Not used


