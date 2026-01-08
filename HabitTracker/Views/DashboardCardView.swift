//
//  DashboardCardView.swift
//  HabitTracker
//
//  Created by Marcelo Casanovas on 7/1/26.
//

import SwiftUI

struct DashboardCardView : View {
   
    let total: Int
    let completed: Int
    let pending: Int
    
    private var progress : Double {
        
        guard total > 0 else {return 0}
        return Double(completed) / Double(total)
    }
    
    var body: some View{
        VStack(alignment: .leading, spacing: 10){
            Text("Dashboard")
                .font(.headline)
            
            HStack{
                stat("Total", total)
                Spacer()
                stat("Completados", completed)
                Spacer()
                stat("Pendientes",pending)
            }
            
            ProgressView(value: progress)
            
        }
        .padding(12)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
    
    private func stat(_ title:String, _ value:Int) -> some View{
        VStack(alignment: .leading, spacing: 2){
            Text(title)
                .font(.caption)
                .opacity(0.7)
            
            Text("\(value)")
                .font(.title3)
                .fontWeight(.semibold)
        }
    }
    
    
}

#Preview {
    DashboardCardView(total: 10, completed: 5, pending: 5)
}

