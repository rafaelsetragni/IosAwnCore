//
//  CreatedManager.swift
//  awesome_notifications
//
//  Created by Rafael Setragni on 15/09/20.
//

import Foundation

public class CreatedManager : EventManager {
    
    let storage:SharedManager = SharedManager(tag: Definitions.SHARED_CREATED)
    
    // **************************** SINGLETON PATTERN *************************************
    
    static var instance:CreatedManager?
    public static var shared:CreatedManager {
        get {
            CreatedManager.instance =
            CreatedManager.instance ?? CreatedManager()
            return CreatedManager.instance!
        }
    }
    private override init(){}
    
    // **************************** OBSERVER PATTERN **************************************
    

    
    public func saveCreated(received:NotificationReceived) -> Bool {
        storage.set(
            received.toMap(),
            referenceKey: getKeyByIdAndDate(
                id: received.id!,
                referenceDate: received.createdDate!
            )
        )
        return true
    }
    
    public func listCreated() -> [NotificationReceived] {
        var returnedList:[NotificationReceived] = []
        let dataList = storage.getAllObjects()
        
        for data in dataList {
            let received:NotificationReceived? = NotificationReceived(nil)
                .fromMap(arguments: data) as? NotificationReceived
            guard let received = received else { continue }
            returnedList.append(received)
        }
        
        return returnedList
    }
    
    public func getCreatedByKey(id:Int) -> [NotificationReceived] {
        var returnedList:[NotificationReceived] = []
        let dataList = storage.getAllObjectsStarting(with: getKeyById(id: id))
        
        for data in dataList {
            let received:NotificationReceived? = NotificationReceived(nil)
                .fromMap(arguments: data) as? NotificationReceived
            guard let received = received else { continue }
            if received.id != id { continue }
            returnedList.append(received)
        }
        
        return returnedList
    }
    
    public func getCreatedByKeyAndDate(id:Int, createdDate:RealDateTime) -> NotificationReceived? {
        guard let data:[String:Any?] = storage.get(
            referenceKey: getKeyByIdAndDate(
                id: id,
                referenceDate: createdDate
            )
        ) else {
          return nil
        }
        return NotificationReceived(nil).fromMap(arguments: data) as? NotificationReceived
    }

    public func cancelAllCreated() {
        storage.removeAll()
    }
    
    public func cancelCreated(id:Int, createdDate:RealDateTime) -> Bool {
        return storage.remove(
            referenceKey: getKeyByIdAndDate(
                id: id,
                referenceDate: createdDate
            )
        )
    }
    
    public func commit() {
        
    }
    
}
