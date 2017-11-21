//
//  AppDelegate.swift
//  Eat!
//
//  Created by Damian Przygodzki on 20/11/2017.
//  Copyright © 2017 Damian Przygodzki. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSUserNotificationCenterDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSUserNotificationCenter.default.delegate = self
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notifcation: NSUserNotification) -> Bool {
        return true
    }
}

