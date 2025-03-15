//
//  InterceptorManager.swift
//  Pods
//
//  Created by Rafael Setragni on 21/10/24.
//
import UIKit
import UserNotifications

struct InterceptorEntry {
    var interceptor: ApplicationDelegateInterceptor
    var priority: Int
}

import UIKit
import UserNotifications

@objc public class InterceptorManager: NSObject {
    static let shared = InterceptorManager()
    private var interceptorEntries = [InterceptorEntry]()
    
    // Method to add an interceptor with control over the order based on priority
    public func subscribe(_ interceptor: ApplicationDelegateInterceptor, withPriority priority: Int) {
        let entry = InterceptorEntry(interceptor: interceptor, priority: priority)
        if interceptorEntries.isEmpty {
            interceptorEntries.append(entry)
        } else {
            let index = interceptorEntries.firstIndex { $0.priority > priority } ?? interceptorEntries.endIndex
            interceptorEntries.insert(entry, at: index)
        }
    }
    
    // Method to remove an interceptor
    public func unsubscribe(_ interceptor: ApplicationDelegateInterceptor) {
        interceptorEntries = interceptorEntries.filter { $0.interceptor !== interceptor }
    }
    
    private func processInterceptors<T>(handler: (ApplicationDelegateInterceptor) -> T?) -> Bool {
        for entry in interceptorEntries {
            if handler(entry.interceptor) != nil {
                return true  // Assume if handler is called, it was handled
            }
        }
        return false
    }

    func didRegisterForRemoteNotificationsWithDeviceToken(_ application: UIApplication, deviceToken: Data) -> Bool {
        return processInterceptors { $0.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken) }
    }

    func didFailToRegisterForRemoteNotificationsWithError(_ application: UIApplication, error: Error) -> Bool {
        return processInterceptors { $0.application?(application, didFailToRegisterForRemoteNotificationsWithError: error) }
    }
    
    func didReceiveRemoteNotification(_ application: UIApplication, userInfo: [AnyHashable: Any], completionHandler: @escaping (UIBackgroundFetchResult) -> Void) -> Bool {
        var handled = false
        for entry in interceptorEntries {
            entry.interceptor.application?(application, didReceiveRemoteNotification: userInfo) { result in
                if !handled {
                    handled = true
                    completionHandler(result)
                }
            }
            if handled { break }
        }
        return handled
    }
    
    func willPresentNotification(_ center: UNUserNotificationCenter, notification: UNNotification, completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) -> Bool {
        var handled = false
        for entry in interceptorEntries {
            entry.interceptor.userNotificationCenter?(center, willPresent: notification) { options in
                if !handled {
                    handled = true
                    completionHandler(options)
                }
            }
            if handled { break }
        }
        return handled
    }
    
    func didReceiveResponse(_ center: UNUserNotificationCenter, response: UNNotificationResponse, completionHandler: @escaping () -> Void) -> Bool {
        var handled = false
        for entry in interceptorEntries {
            entry.interceptor.userNotificationCenter?(center, didReceive: response) {
                if !handled {
                    handled = true
                    completionHandler()
                }
            }
            if handled { break }
        }
        return handled
    }
}
