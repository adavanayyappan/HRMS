//
//  Constants.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 28/06/24.
//

import Foundation

enum Constants: String {
    case baseUrl = "http://portal.bsnet.biz/hrms/api/"
    case loginUrl = "users/login"
    case changePasswordUrl = "users/changepassword"
    case forgotPasswordUrl = "users/forgotpassword"
    case resetPasswordUrl = "users/resetpassword"
    case timeSheetUrl = "attendance/punchinglist"
    case uploadFaceUrl = "attendance/addFace"
    case imageURL = "http://portal.bsnet.biz/hrms/media/face/";
    case punchingstatusUrl = "attendance/punchingstatus"
    case punchingUrl = "attendance/punching"
    case leavelistUrl = "Leave/leavelist"
    case leaveTypeUrl = "leaveType/dropdownlist"
    case leaverequestlistUrl = "Leave/requestlist"
    case leaveApprovalListUrl = "Leave/myapproval"
    case claimlistUrl = "claim/claimgroup"
    case claimrequestlistUrl = "claim/requestlist"
    case claimApprovalListUrl = "claim/myapproval"
    case leaveApply = "Leave/apply"
    case claimApply = "claim/apply"
    case leaveUpdatestatus = "Leave/updatestatus"
    case claimUpdatestatus = "claim/updatestatus"
}

struct AppStorageKeys {
    static let isLoggedIn = "isLoggedIn"
    static let KEY_EMP_ID = "empID"
    static let KEY_CLIENT_ID = "clientID"
    static let KEY_TOKEN = "token"
    static let KEY_NAME = "empName"
    static let KEY_ISLOGGEDIN = "isLoggedIn"
    static let KEY_EMP_IMAGE = "faceImage"
}

