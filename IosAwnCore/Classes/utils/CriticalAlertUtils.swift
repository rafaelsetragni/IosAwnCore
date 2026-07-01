//
//  CriticalAlertUtils.swift
//  IosAwnCore
//

import Foundation
import UserNotifications

@available(iOS 10.0, *)
public class CriticalAlertUtils {

    private static var cachedCanDeliver: Bool?

    public static func updateCache(from settings: UNNotificationSettings) {
        if #available(iOS 12.0, *) {
            cachedCanDeliver = settings.criticalAlertSetting == .enabled
        } else {
            cachedCanDeliver = false
        }
    }

    public static func clearCache() {
        cachedCanDeliver = nil
    }

    /// Whether critical alerts can be delivered right now.
    ///
    /// A pure, non-blocking cache read. The value is resolved asynchronously
    /// before the notification is built (see [ensureAvailabilityResolved]), so by
    /// the time this is called from the build path the cache already holds the
    /// real value. Defaults to `false` only if it was never resolved.
    public static func canDeliverCriticalAlerts() -> Bool {
        return cachedCanDeliver ?? false
    }

    /// Resolves the critical-alert availability into the cache (asynchronously,
    /// without blocking) and then runs [then].
    ///
    /// Call this in the already-async notification send flow, right before
    /// building, so the synchronous [canDeliverCriticalAlerts] always reads a
    /// fresh value. If the cache is already populated it runs [then] immediately;
    /// otherwise it queries the settings once, updates the cache, and continues.
    /// This covers the app-extension path too, where the global permission check
    /// short-circuits and would otherwise leave the cache cold.
    public static func ensureAvailabilityResolved(_ then: @escaping () -> Void) {
        if cachedCanDeliver != nil {
            then()
            return
        }
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            updateCache(from: settings)
            then()
        }
    }

    public static func isCriticalAlertRequested(
        channel: NotificationChannelModel,
        notificationModel: NotificationModel
    ) -> Bool {
        return (channel.criticalAlerts ?? false) ||
            (notificationModel.content?.criticalAlert ?? false)
    }
}
