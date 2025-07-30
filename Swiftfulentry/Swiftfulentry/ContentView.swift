//
//  ContentView.swift
//  Swiftfulentry
//
//  Created by Akash Kallumkal on 2025-07-28.
//

import SwiftUI

// MARK: - Event Model
struct Event: Identifiable, Codable {
    var id = UUID()
    var name: String
    var date: Date
    var location: String
    var maxAttendees: Int
    var description: String
    var isCreatedByUser: Bool
    
    init(name: String, date: Date, location: String, maxAttendees: Int, description: String = "", isCreatedByUser: Bool = true) {
        self.name = name
        self.date = date
        self.location = location
        self.maxAttendees = maxAttendees
        self.description = description
        self.isCreatedByUser = isCreatedByUser
    }
}

// MARK: - Event List View
struct EventListView: View {
    let events: [Event]
    
    var body: some View {
        if events.isEmpty {
            VStack(spacing: 16) {
                Image(systemName: "calendar.badge.plus")
                    .font(.system(size: 60))
                    .foregroundColor(.gray)
                
                Text("No events yet")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Text("Create or join one to get started!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        } else {
            List(events) { event in
                EventRowView(event: event)
            }
            .listStyle(PlainListStyle())
        }
    }
}

// MARK: - Event Row View
struct EventRowView: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(event.date, style: .date)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .font(.caption)
                            .foregroundColor(.blue)
                        
                        Text(event.location)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(event.maxAttendees) max")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if event.isCreatedByUser {
                        Text("Created")
                            .font(.caption2)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(Color.green.opacity(0.2))
                            .foregroundColor(.green)
                            .cornerRadius(4)
                    } else {
                        Text("Joined")
                            .font(.caption2)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(Color.blue.opacity(0.2))
                            .foregroundColor(.blue)
                            .cornerRadius(4)
                    }
                }
            }
            
            if !event.description.isEmpty {
                Text(event.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Main Dashboard View
struct ContentView: View {
    @State private var events: [Event] = []
    @State private var showingCreateEvent = false
    @State private var showingJoinEvent = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 8) {
                    Text("SwiftfulEntry")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("Event Dashboard")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
                .padding(.bottom, 16)
                
                // Action Buttons
                HStack(spacing: 16) {
                    Button(action: {
                        showingCreateEvent = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title3)
                            Text("Create Event")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(12)
                    }
                    
                    Button(action: {
                        showingJoinEvent = true
                    }) {
                        HStack {
                            Image(systemName: "person.2.fill")
                                .font(.title3)
                            Text("Join Event")
                                .font(.headline)
                        }
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
                
                // Events List
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Your Events")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("\(events.count) event\(events.count == 1 ? "" : "s")")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 20)
                    
                    EventListView(events: events)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showingCreateEvent) {
            CreateEventView(events: $events)
        }
        .sheet(isPresented: $showingJoinEvent) {
            JoinEventView(events: $events)
        }
    }
}

#Preview {
    ContentView()
}
