//
//  StatusMenuController.swift
//  Eat!
//
//  Created by Damian Przygodzki on 20/11/2017.
//  Copyright © 2017 Damian Przygodzki. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var nextMealInfo: NSMenuItem!
    @IBOutlet weak var start: NSMenuItem!
    
    let mealInterval = 9000;
    var mealCount = 0;
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    override func awakeFromNib() {
        statusItem.title = "🥘"
        statusItem.menu = statusMenu
    }
    
    func getTimeString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+1")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
    func scheduleNotification(_ time: DispatchTime) {
        unowned let unownedSelf = self
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            NSSound(named: NSSound.Name(rawValue: "Purr"))?.play()
            
            let notification = NSUserNotification()
            notification.title = "Eat now!"
            notification.informativeText = "You should eat next dish!"
            
            NSUserNotificationCenter
                .default
                .deliver(notification)
            
            unownedSelf.mealEaten()
        })
    }
    
    func mealEaten() {
        mealCount += 1
        if(mealCount == 6){
            return endOfDay()
        }
        let humanTime = Date()
        let dispatchTime = DispatchTime.now() + .seconds(mealInterval)
        scheduleNotification(dispatchTime)
        nextMealInfo.title = "Next meal at " + getTimeString(
            humanTime.addingTimeInterval(TimeInterval(mealInterval))
        )
    }
    
    func endOfDay() {
        mealCount = 0
        start.isHidden = false
        nextMealInfo.title = "Next meal at -"
    }
    
    @IBAction func breakfastEaten(_ sender: NSMenuItem) {
        start.isHidden = true
        
        mealEaten()
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
}
