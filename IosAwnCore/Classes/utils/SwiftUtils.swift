//
//  SwiftUtils.swift
//  Pods
//
//  Created by Rafael Setragni on 16/10/20.
//

import Foundation
import UIKit
public class SwiftUtils{

    private static var _isExtension:Bool?

    public static func isRunningOnExtension() -> Bool {
        if _isExtension == nil {
            _isExtension = Bundle.main.bundlePath.hasSuffix(".appex")
        }
        return _isExtension!
    }

    /// Resolves `UIApplication.shared` through the Objective-C runtime so that the
    /// app-only code paths that need it still compile when this package is linked into
    /// an app extension (built with `-application-extension`, where `shared` is marked
    /// unavailable). Inside an extension this returns nil; combined with the
    /// `isRunningOnExtension()` guards at the call sites, those paths never run there.
    public static func sharedApplication() -> UIApplication? {
        let selector = NSSelectorFromString("sharedApplication")
        let applicationClass: AnyObject? = NSClassFromString("UIApplication")
        guard let appClass = applicationClass, appClass.responds(to: selector) else {
            return nil
        }
        return appClass.perform(selector)?.takeUnretainedValue() as? UIApplication
    }
    
    public static func getMainBundle() -> Bundle {
        var components = Bundle.main.bundleURL.path.split(separator: "/")
        var bundle: Bundle?

        if let index = components.lastIndex(where: { $0.hasSuffix(".app") }) {
            components.removeLast((components.count - 1) - index)
            bundle = Bundle(path: components.joined(separator: "/"))
        }

        return bundle ?? Bundle.main
    }
    
    public static func getFlutterAssetPath(forAsset assetPath:String) -> String? {
        let realPath = getMainBundle().bundlePath + "/Frameworks/App.framework/flutter_assets/" + assetPath
        return realPath
    }
}
