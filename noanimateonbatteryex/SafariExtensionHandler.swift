//
//  SafariExtensionHandler.swift
//  noanimateonbatteryex
//
//  Created by Zac Brown on 7/2/17.
//  Copyright © 2017 Zac Brown. All rights reserved.
//

import SafariServices
import IOKit.ps

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]? = nil) {
        logStatus(msg: "message received")
        if messageName == "CheckIfBatteryPowered" {
            logStatus(msg: "CheckIfBatteryPowered message")
            if isOnBatteryPower() {
                logStatus(msg: "device is running on battery, dispatching OnBatteryPower event")
                page.dispatchMessageToScript(withName: "OnBatteryPower", userInfo: [:]);
            } else {
                logStatus(msg: "device is not running on battery")
            }
        }
    }
    
    func isOnBatteryPower() -> Bool {
        return IOPSGetTimeRemainingEstimate() != kIOPSTimeRemainingUnlimited;
    }
    
    func logStatus(msg : String) -> Void {
        #if DEBUG
            NSLog("[noanimateonbattery] %@", msg)
        #endif
    }
}
