//
//  NotificationContentModel.swift
//  IosAwnCore_Tests
//
//  Created by Rafael Setragni on 26/09/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import IosAwnCore

var payloadTest:[String:String?]? = nil
var dateTestExample:String? = nil
var realDateTestExample:RealDateTime? = nil

final class NotificationContentModelTest: XCTestCase {

    override func setUpWithError() throws {
        payloadTest = ["key": "value"]
        dateTestExample = "2023-09-26 00:00:00 GMT"
        realDateTestExample = RealDateTime(fromDateText: dateTestExample!, defaultTimeZone: TimeZone.init(identifier: "GMT"))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFromMapRandomId() {
        XCTAssertEqual(NotificationContentModel(fromMap: [Definitions.NOTIFICATION_ID: 0])?.id, 0)
        XCTAssertEqual(NotificationContentModel(fromMap: [Definitions.NOTIFICATION_ID: 1])?.id, 1)
        XCTAssertGreaterThanOrEqual(NotificationContentModel(fromMap: [Definitions.NOTIFICATION_ID: -1])?.id ?? -1, 0)
        XCTAssertGreaterThanOrEqual(NotificationContentModel(fromMap: [Definitions.NOTIFICATION_ID: -2])?.id ?? -1, 0)
        XCTAssertGreaterThanOrEqual(NotificationContentModel(fromMap: [Definitions.NOTIFICATION_ID: nil])?.id ?? -1, 0)
    }

    func testFromMapInitializer() {
        // Given
        let expectedId = 123
        let expectedChannelKey = "test_channel"
        let expectedGroupKey = "test_group"
        let expectedTitle = "test_title"
        let expectedBody = "test_body"
        let expectedSummary = "test_summary"
        let expectedShowWhen = true
        let expectedWakeUpScreen = true
        let expectedPlaySound = true
        let expectedCustomSound = "test_sound"
        let expectedLocked = true
        let expectedIcon = "test_icon"
        let expectedLargeIcon = "test_large_icon"
        let expectedBigPicture = "test_big_picture"
        let expectedHideLargeIconOnExpand = true
        let expectedAutoDismissible = true
        let expectedDisplayOnForeground = true
        let expectedDisplayOnBackground = true
        let expectedColor: Int64 = 123456
        let expectedBackgroundColor: Int64 = 654321
        let expectedProgress = 50
        let expectedBadge = 5
        let expectedTicker = "test_ticker"
        let expectedRoundedLargeIcon = true
        let expectedRoundedBigPicture = true
        let expectedActionType = ActionType.SilentAction.rawValue
        let expectedPrivacy = NotificationPrivacy.Private.rawValue
        let expectedPrivateMessage = "test_private_message"
        let expectedNotificationLayout = NotificationLayout.BigPicture.rawValue
        let expectedCreatedSource = NotificationSource.Firebase.rawValue
        let expectedCreatedLifeCycle = NotificationLifeCycle.Terminated.rawValue
        let expectedDisplayedLifeCycle = NotificationLifeCycle.Foreground.rawValue
        let testStringDate = "2023-09-26 00:00:00"
        let testRealDateTime = RealDateTime.init(fromDateText: testStringDate, inTimeZone: TimeZone.init(identifier: "UTC")!)
        
        let expectedCreatedDate = testStringDate
        let expectedDisplayedDate = testStringDate
        let expectedPayload: [String: String?] = ["key": "value"]

        let map: [String: Any?] = [
            Definitions.NOTIFICATION_ID: expectedId,
            Definitions.NOTIFICATION_CHANNEL_KEY: expectedChannelKey,
            Definitions.NOTIFICATION_GROUP_KEY: expectedGroupKey,
            Definitions.NOTIFICATION_TITLE: expectedTitle,
            Definitions.NOTIFICATION_BODY: expectedBody,
            Definitions.NOTIFICATION_SUMMARY: expectedSummary,
            Definitions.NOTIFICATION_SHOW_WHEN: expectedShowWhen,
            Definitions.NOTIFICATION_WAKE_UP_SCREEN: expectedWakeUpScreen,
            Definitions.NOTIFICATION_PLAY_SOUND: expectedPlaySound,
            Definitions.NOTIFICATION_CUSTOM_SOUND: expectedCustomSound,
            Definitions.NOTIFICATION_LOCKED: expectedLocked,
            Definitions.NOTIFICATION_ICON: expectedIcon,
            Definitions.NOTIFICATION_LARGE_ICON: expectedLargeIcon,
            Definitions.NOTIFICATION_BIG_PICTURE: expectedBigPicture,
            Definitions.NOTIFICATION_HIDE_LARGE_ICON_ON_EXPAND: expectedHideLargeIconOnExpand,
            Definitions.NOTIFICATION_AUTO_DISMISSIBLE: expectedAutoDismissible,
            Definitions.NOTIFICATION_DISPLAY_ON_FOREGROUND: expectedDisplayOnForeground,
            Definitions.NOTIFICATION_DISPLAY_ON_BACKGROUND: expectedDisplayOnBackground,
            Definitions.NOTIFICATION_COLOR: expectedColor,
            Definitions.NOTIFICATION_BACKGROUND_COLOR: expectedBackgroundColor,
            Definitions.NOTIFICATION_PROGRESS: expectedProgress,
            Definitions.NOTIFICATION_BADGE: expectedBadge,
            Definitions.NOTIFICATION_TICKER: expectedTicker,
            Definitions.NOTIFICATION_ROUNDED_LARGE_ICON: expectedRoundedLargeIcon,
            Definitions.NOTIFICATION_ROUNDED_BIG_PICTURE: expectedRoundedBigPicture,
            Definitions.NOTIFICATION_ACTION_TYPE: expectedActionType,
            Definitions.NOTIFICATION_PRIVACY: expectedPrivacy,
            Definitions.NOTIFICATION_PRIVATE_MESSAGE: expectedPrivateMessage,
            Definitions.NOTIFICATION_LAYOUT: expectedNotificationLayout,
            Definitions.NOTIFICATION_CREATED_SOURCE: expectedCreatedSource,
            Definitions.NOTIFICATION_CREATED_LIFECYCLE: expectedCreatedLifeCycle,
            Definitions.NOTIFICATION_DISPLAYED_LIFECYCLE: expectedDisplayedLifeCycle,
            Definitions.NOTIFICATION_CREATED_DATE: expectedCreatedDate,
            Definitions.NOTIFICATION_DISPLAYED_DATE: expectedDisplayedDate,
            Definitions.NOTIFICATION_PAYLOAD: expectedPayload
        ]
        
        // When
        let model = NotificationContentModel(fromMap: map)
        
        // Then
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.id, expectedId)
        XCTAssertEqual(model?.channelKey, expectedChannelKey)
        XCTAssertEqual(model?.groupKey, expectedGroupKey)
        XCTAssertEqual(model?.title, expectedTitle)
        XCTAssertEqual(model?.body, expectedBody)
        XCTAssertEqual(model?.summary, expectedSummary)
        XCTAssertEqual(model?.showWhen, expectedShowWhen)
        XCTAssertEqual(model?.wakeUpScreen, expectedWakeUpScreen)
        XCTAssertEqual(model?.playSound, expectedPlaySound)
        XCTAssertEqual(model?.customSound, expectedCustomSound)
        XCTAssertEqual(model?.locked, expectedLocked)
        XCTAssertEqual(model?.icon, expectedIcon)
        XCTAssertEqual(model?.largeIcon, expectedLargeIcon)
        XCTAssertEqual(model?.bigPicture, expectedBigPicture)
        XCTAssertEqual(model?.hideLargeIconOnExpand, expectedHideLargeIconOnExpand)
        XCTAssertEqual(model?.autoDismissible, expectedAutoDismissible)
        XCTAssertEqual(model?.displayOnForeground, expectedDisplayOnForeground)
        XCTAssertEqual(model?.displayOnBackground, expectedDisplayOnBackground)
        XCTAssertEqual(model?.color, expectedColor)
        XCTAssertEqual(model?.backgroundColor, expectedBackgroundColor)
        XCTAssertEqual(model?.progress, expectedProgress)
        XCTAssertEqual(model?.badge, expectedBadge)
        XCTAssertEqual(model?.ticker, expectedTicker)
        XCTAssertEqual(model?.roundedLargeIcon, expectedRoundedLargeIcon)
        XCTAssertEqual(model?.roundedBigPicture, expectedRoundedBigPicture)
        XCTAssertEqual(model?.actionType?.rawValue, expectedActionType) // Enum comparison
        XCTAssertEqual(model?.privacy?.rawValue, expectedPrivacy) // Enum comparison
        XCTAssertEqual(model?.privateMessage, expectedPrivateMessage)
        XCTAssertEqual(model?.notificationLayout?.rawValue, expectedNotificationLayout) // Enum comparison
        XCTAssertEqual(model?.createdSource?.rawValue, expectedCreatedSource) // Enum comparison
        XCTAssertEqual(model?.createdLifeCycle?.rawValue, expectedCreatedLifeCycle) // Enum comparison
        XCTAssertEqual(model?.displayedLifeCycle?.rawValue, expectedDisplayedLifeCycle) // Enum comparison
        XCTAssertEqual(model?.createdDate, testRealDateTime)
        XCTAssertEqual(model?.displayedDate, testRealDateTime)
        XCTAssertEqual(model?.payload, expectedPayload)
    }

    func testToMap() {
        
        // Given
        let model = NotificationContentModel()
        model.id = 123
        model.channelKey = "test_channel"
        model.groupKey = "test_group"
        model.title = "test_title"
        model.body = "test_body"
        model.summary = "test_summary"
        model.showWhen = true
        model.wakeUpScreen = true
        model.playSound = true
        model.customSound = "test_sound"
        model.locked = true
        model.icon = "test_icon"
        model.largeIcon = "test_large_icon"
        model.bigPicture = "test_big_picture"
        model.hideLargeIconOnExpand = true
        model.autoDismissible = true
        model.displayOnForeground = true
        model.displayOnBackground = true
        model.color = 123456
        model.backgroundColor = 654321
        model.progress = 50
        model.badge = 5
        model.ticker = "test_ticker"
        model.roundedLargeIcon = true
        model.roundedBigPicture = true
        model.actionType = .SilentAction // Assuming ActionType enum exists
        model.privacy = .Private // Assuming NotificationPrivacy enum exists
        model.privateMessage = "test_private_message"
        model.notificationLayout = .BigPicture // Assuming NotificationLayout enum exists
        model.createdSource = .Firebase // Assuming NotificationSource enum exists
        model.createdLifeCycle = .Terminated // Assuming NotificationLifeCycle enum exists
        model.displayedLifeCycle = .Foreground // Assuming NotificationLifeCycle enum exists
        model.createdDate = realDateTestExample
        model.displayedDate = realDateTestExample
        model.payload = payloadTest

        // When
        let map = model.toMap()

        // Then
        XCTAssertNotNil(map)
        XCTAssertEqual(map[Definitions.NOTIFICATION_ID] as? Int, model.id)
        XCTAssertEqual(map[Definitions.NOTIFICATION_CHANNEL_KEY] as? String, model.channelKey)
        XCTAssertEqual(map[Definitions.NOTIFICATION_GROUP_KEY] as? String, model.groupKey)
        XCTAssertEqual(map[Definitions.NOTIFICATION_TITLE] as? String, model.title)
        XCTAssertEqual(map[Definitions.NOTIFICATION_BODY] as? String, model.body)
        XCTAssertEqual(map[Definitions.NOTIFICATION_SUMMARY] as? String, model.summary)
        XCTAssertEqual(map[Definitions.NOTIFICATION_SHOW_WHEN] as? Bool, model.showWhen)
        XCTAssertEqual(map[Definitions.NOTIFICATION_WAKE_UP_SCREEN] as? Bool, model.wakeUpScreen)
        XCTAssertEqual(map[Definitions.NOTIFICATION_PLAY_SOUND] as? Bool, model.playSound)
        XCTAssertEqual(map[Definitions.NOTIFICATION_CUSTOM_SOUND] as? String, model.customSound)
        XCTAssertEqual(map[Definitions.NOTIFICATION_LOCKED] as? Bool, model.locked)
        XCTAssertEqual(map[Definitions.NOTIFICATION_ICON] as? String, model.icon)
        XCTAssertEqual(map[Definitions.NOTIFICATION_LARGE_ICON] as? String, model.largeIcon)
        XCTAssertEqual(map[Definitions.NOTIFICATION_BIG_PICTURE] as? String, model.bigPicture)
        XCTAssertEqual(map[Definitions.NOTIFICATION_HIDE_LARGE_ICON_ON_EXPAND] as? Bool, model.hideLargeIconOnExpand)
        XCTAssertEqual(map[Definitions.NOTIFICATION_AUTO_DISMISSIBLE] as? Bool, model.autoDismissible)
        XCTAssertEqual(map[Definitions.NOTIFICATION_DISPLAY_ON_FOREGROUND] as? Bool, model.displayOnForeground)
        XCTAssertEqual(map[Definitions.NOTIFICATION_DISPLAY_ON_BACKGROUND] as? Bool, model.displayOnBackground)
        XCTAssertEqual(map[Definitions.NOTIFICATION_COLOR] as? Int64, model.color)
        XCTAssertEqual(map[Definitions.NOTIFICATION_BACKGROUND_COLOR] as? Int64, model.backgroundColor)
        XCTAssertEqual(map[Definitions.NOTIFICATION_PROGRESS] as? Int, model.progress)
        XCTAssertEqual(map[Definitions.NOTIFICATION_BADGE] as? Int, model.badge)
        XCTAssertEqual(map[Definitions.NOTIFICATION_TICKER] as? String, model.ticker)
        XCTAssertEqual(map[Definitions.NOTIFICATION_ROUNDED_LARGE_ICON] as? Bool, model.roundedLargeIcon)
        XCTAssertEqual(map[Definitions.NOTIFICATION_ROUNDED_BIG_PICTURE] as? Bool, model.roundedBigPicture)
        XCTAssertEqual(map[Definitions.NOTIFICATION_ACTION_TYPE] as? String, model.actionType?.rawValue)
        XCTAssertEqual(map[Definitions.NOTIFICATION_PRIVACY] as? String, model.privacy?.rawValue)
        XCTAssertEqual(map[Definitions.NOTIFICATION_PRIVATE_MESSAGE] as? String, model.privateMessage)
        XCTAssertEqual(map[Definitions.NOTIFICATION_LAYOUT] as? String, model.notificationLayout?.rawValue)
        XCTAssertEqual(map[Definitions.NOTIFICATION_CREATED_SOURCE] as? String, model.createdSource?.rawValue)
        XCTAssertEqual(map[Definitions.NOTIFICATION_CREATED_LIFECYCLE] as? String, model.createdLifeCycle?.rawValue)
        XCTAssertEqual(map[Definitions.NOTIFICATION_DISPLAYED_LIFECYCLE] as? String, model.displayedLifeCycle?.rawValue)
        XCTAssertEqual(map[Definitions.NOTIFICATION_CREATED_DATE] as? String, dateTestExample)
        XCTAssertEqual(map[Definitions.NOTIFICATION_DISPLAYED_DATE] as? String, dateTestExample)
        XCTAssertEqual(map[Definitions.NOTIFICATION_PAYLOAD] as? [String:String?], payloadTest)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
