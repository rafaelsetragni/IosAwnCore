//
//  BadgeManager.swift
//  awesome_notifications
//
//  Created by Rafael Setragni on 17/11/21.
//

import Foundation
import UIKit
import UserNotifications

public class BadgeManager : AwesomeLifeCycleEventListener {
    let TAG:String = "BadgeManager"
    
    // ************** SINGLETON PATTERN ***********************
    
    static var instance:BadgeManager?
    public static var shared:BadgeManager {
        get {
            BadgeManager.instance =
                BadgeManager.instance ?? BadgeManager()
            return BadgeManager.instance!
        }
    }
    
    private init(){
        _ = LifeCycleManager.shared.subscribe(listener: self)
    }
    
    public func onNewLifeCycleEvent(lifeCycle: NotificationLifeCycle) {
        syncBadgeAmount()
    }
    
    // ********************************************************
    
    private var _badgeAmount:NSNumber = 0

    public var globalBadgeCounter:Int {
        get {
            if !SwiftUtils.isRunningOnExtension() && Thread.isMainThread {
                _badgeAmount = NSNumber(value: BadgeManager.readApplicationBadge())
            }
            else{
                let userDefaults = UserDefaults(suiteName: Definitions.USER_DEFAULT_TAG)
                let badgeCount:Int = userDefaults!.integer(forKey: Definitions.BADGE_COUNT)
                _badgeAmount = NSNumber(value: badgeCount)
            }
            return _badgeAmount.intValue
        }

        set {
            _badgeAmount = NSNumber(value: newValue)

            if !SwiftUtils.isRunningOnExtension() && Thread.isMainThread {
                BadgeManager.writeApplicationBadge(newValue)
            }
            setGlobalBadgeCounterInStorage(newValue: newValue)
        }
    }

    /// Reads the app icon badge value through the Objective-C runtime so this file
    /// compiles under `-application-extension`. Only reached in the host app (guarded
    /// by `isRunningOnExtension()`); extensions read the mirrored value from storage.
    private static func readApplicationBadge() -> Int {
        guard let application = SwiftUtils.sharedApplication() else { return 0 }
        return (application.value(forKey: "applicationIconBadgeNumber") as? Int) ?? 0
    }

    /// Writes the app icon badge using the app-extension-safe API on iOS 16+ (which also
    /// replaces `applicationIconBadgeNumber`, deprecated since iOS 17), falling back to the
    /// legacy property via the runtime on older iOS. Only reached in the host app.
    private static func writeApplicationBadge(_ value: Int) {
        if #available(iOS 16.0, *) {
            UNUserNotificationCenter.current().setBadgeCount(value)
        } else {
            SwiftUtils.sharedApplication()?.setValue(value, forKey: "applicationIconBadgeNumber")
        }
    }
    
    public func syncBadgeAmount(){
        setGlobalBadgeCounterInStorage(newValue: globalBadgeCounter)
    }
    
    public func setGlobalBadgeCounterInStorage(newValue:Int) {
        let userDefaults = UserDefaults(suiteName: Definitions.USER_DEFAULT_TAG)
        userDefaults!.set(newValue, forKey: Definitions.BADGE_COUNT)
    }

    public func resetGlobalBadgeCounter() {
        globalBadgeCounter = 0
    }

    public func incrementGlobalBadgeCounter() -> Int {
        globalBadgeCounter += 1
        return globalBadgeCounter
    }

    public func decrementGlobalBadgeCounter() -> Int {
        globalBadgeCounter = max(globalBadgeCounter - 1, 0)
        return globalBadgeCounter
    }

}
