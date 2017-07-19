//
// Constants.swift
// sampleapp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 15/07/17
//

import Foundation
import SAPFoundation

struct Constants {

    static let appId = "com.pkallu.sampleapp"
    private static let sapcpmsUrlString = "https://hcpms-p1942658642trial.hanatrial.ondemand.com/"
    static let sapcpmsUrl = URL(string: sapcpmsUrlString)!
    static let appUrl = Constants.sapcpmsUrl.appendingPathComponent(appId)
    static let configurationParameters = SAPcpmsSettingsParameters(backendURL: Constants.sapcpmsUrl, applicationID: Constants.appId)
}
