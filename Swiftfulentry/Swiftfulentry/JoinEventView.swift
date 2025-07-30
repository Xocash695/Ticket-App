//
//  JoinEventView.swift
//  Swiftfulentry
//
//  Created by Akash Kallumkal on 2025-07-28.
//

import SwiftUI

struct JoinEventView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var events: [Event]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "person.2.circle")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("Join Event")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("This feature is coming soon!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                // Mock join functionality for demo
                Button("Join Demo Event") {
                    let demoEvent = Event(
                        name: "Demo Conference",
                        date: Date().addingTimeInterval(86400), // Tomorrow
                        location: "Conference Center",
                        maxAttendees: 50,
                        description: "A demo event to show the join functionality",
                        isCreatedByUser: false
                    )
                    events.append(demoEvent)
                    events.sort { $0.date > $1.date }
                    dismiss()
                }
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.blue)
                .cornerRadius(8)
            }
            .padding()
            .navigationTitle("Join Event")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    JoinEventView(events: .constant([]))
} 