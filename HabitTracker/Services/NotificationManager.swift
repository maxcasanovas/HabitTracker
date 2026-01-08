//
//  NotificationManager.swift
//  HabitTracker
//
//  Created by Marcelo Casanovas on 7/1/26.
//

import Foundation
import UserNotifications
import CoreData

final class NotificationManager {
    
    static let shared = NotificationManager()
    private init() {}
    
    
    private let center = UNUserNotificationCenter.current()
    private let dailySummaryId = "daily_habits_summary"
    
    
    func requestAuthorization() async -> Bool {
        do{
            let granted = try await center.requestAuthorization(options: [.alert, .sound, .badge])
            return granted
            
        }catch{
            print("Error de permisos para la notificacion", error.localizedDescription)
            return false
        }
        
    }
    
    func cancelDailySummary(){
        center.removePendingNotificationRequests(withIdentifiers: [dailySummaryId])
    }
    
    func shcheduleDailySummary(at hour: Int, minute: Int, pendingCount: Int) async {
        cancelDailySummary()
        
        let content = UNMutableNotificationContent()
        content.title = "Habit Tracker"
        content.sound = .default
        
        if pendingCount <= 0 {
            content.body = "Hoy vas al dia, no tienes pendientes"
            
        }else if pendingCount == 1 {
            content.body = "Te queda 1 habito para completar hoy"
        }else{
            content.body = "Te quedan \(pendingCount) Habitos por completar"
        }
        
        //Trigger diario
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier:dailySummaryId , content: content, trigger: trigger)
        
        do{
            try await center.add(request)
        }catch{
            print("Error al agendar notificacion", error.localizedDescription)
        }
    }
    
}
