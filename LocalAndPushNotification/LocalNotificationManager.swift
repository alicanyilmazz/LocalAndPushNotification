//
//  NotificationManager.swift
//  LocalAndPushNotification
//
//  Created by alican on 27.11.2021.
//

import Foundation
import UIKit
import CoreLocation

struct LocalNotification{
    var id : String
    var title : String
    var body : String
}

enum LocalNotificationDurationType{
    case days
    case hours
    case minutes
    case seconds
}

struct LocalNotificationManager{
    static private var notifications = [LocalNotification]()
    static private func requestPermission() -> Void{
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge , .alert]) { granted, error in
            if granted == true && error == nil{
                // We have a permission
            }
        }
    }
    
    static private func addNotification(title : String , body : String) -> Void{
        notifications.append(LocalNotification(id: UUID().uuidString, title: title, body: body))     
    }
    
    static private func scheduleNotifications(_ durationInSeconds: Int , repeats: Bool , userInfo: [AnyHashable : Any]){
        UIApplication.shared.applicationIconBadgeNumber = 0
        for notification in notifications{
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
            content.sound = UNNotificationSound.default
            content.launchImageName = "background"
            content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
            content.userInfo = userInfo
            let url = Bundle.main.url(forResource: "background", withExtension: "pdf")!
            let attachment = try? UNNotificationAttachment(identifier: "noti", url: url, options: nil)
            content.attachments = [attachment!]
            
            let triggger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(durationInSeconds), repeats: repeats)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: triggger)
            
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else {return}
                print("Scheduling notification with id: \(notification.id)")
            }
        }
        notifications.removeAll()
    }
    
    static private func scheduleNotifications(_ duration: Int , of type: LocalNotificationDurationType, repeats: Bool , userInfo: [AnyHashable : Any]){
        var seconds = 0
        switch type {
        case .days:
            seconds = duration * 60 * 60 * 24
        case .hours:
            seconds = duration * 60 * 60
        case .minutes:
            seconds = duration * 60
        case .seconds:
            seconds = duration
        }
        scheduleNotifications(seconds, repeats: repeats, userInfo: userInfo)
    }
    
    static private func scheduleNotifications(_ dateComponent: DateComponents , repeats: Bool , userInfo: [AnyHashable : Any]){
        UIApplication.shared.applicationIconBadgeNumber = 0
        for notification in notifications{
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
            content.sound = UNNotificationSound.default
            content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
            content.launchImageName = "background"
            content.userInfo = userInfo
            
            let triggger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: repeats)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: triggger)
            
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else {return}
                print("Scheduling notification with id: \(notification.id)")
            }
        }
        notifications.removeAll()
    }
    
    static private func scheduleNotifications(_ latitude : CLLocationDegrees , _ longitude :  CLLocationDegrees, repeats: Bool , userInfo: [AnyHashable : Any]){
        UIApplication.shared.applicationIconBadgeNumber = 0
        for notification in notifications{
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
            content.sound = UNNotificationSound.default
            content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
            content.launchImageName = "background"
            content.userInfo = userInfo
            let url = Bundle.main.url(forResource: "", withExtension: "png")!
            let attachment = try? UNNotificationAttachment(identifier: "noti", url: url, options: nil)
            content.attachments = [attachment!]
            
            //let _latitude = CLLocationDegrees(exactly: 41.2)!
            //let _longitude = CLLocationDegrees(exactly: 34.2)!
            //let location = CLLocation(latitude: _latitude, longitude: _longitude)
            //let triggger = UNLocationNotificationTrigger(region: location, repeats: repeats)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: nil)
            
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else {return}
                print("Scheduling notification with id: \(notification.id)")
            }
        }
        notifications.removeAll()
    }
        
    static func cancel(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    static func setNotification(_ duration: Int , of type: LocalNotificationDurationType , repeats : Bool , title :  String , body : String , userInfo: [AnyHashable : Any]){
        requestPermission()
        addNotification(title: title, body: body)
        scheduleNotifications(duration, of: type, repeats: repeats, userInfo: userInfo)
    }
    
    static func setNotification(_ dateComponent: DateComponents , repeats : Bool , title :  String , body : String , userInfo: [AnyHashable : Any]){
        requestPermission()
        addNotification(title: title, body: body)
        scheduleNotifications(dateComponent, repeats: repeats, userInfo: userInfo)
    }
    
    static func setNotification(_ latitude : CLLocationDegrees , _ longitude :  CLLocationDegrees, repeats : Bool , title :  String , body : String , userInfo: [AnyHashable : Any]){
        requestPermission()
        addNotification(title: title, body: body)
        scheduleNotifications(latitude, longitude, repeats: repeats, userInfo: userInfo)
    }
}
