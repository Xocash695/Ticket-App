//
//  CreateEventView.swift
//  Swiftfulentry
//
//  Created by Akash Kallumkal on 2025-07-28.
//

import SwiftUI

struct CreateEventView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var events: [Event]
    
    @State private var eventName = ""
    @State private var eventDate = Date()
    @State private var eventLocation = ""
    @State private var maxAttendees = ""
    @State private var description = ""
    
    @State private var showingValidationAlert = false
    @State private var validationMessage = ""
    
    private var isFormValid: Bool {
        !eventName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !eventLocation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !maxAttendees.isEmpty &&
        Int(maxAttendees) != nil &&
        Int(maxAttendees) ?? 0 > 0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Event Name")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        TextField("Enter event name", text: $eventName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Event Date")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        DatePicker("Select date", selection: $eventDate, displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(CompactDatePickerStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Event Location")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        TextField("Enter location", text: $eventLocation)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Max Attendees")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        TextField("Enter max attendees", text: $maxAttendees)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                }
                
                Section(header: Text("Description (Optional)")) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Event Description")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        TextEditor(text: $description)
                            .frame(minHeight: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                }
            }
            .navigationTitle("Create Event")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveEvent()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
        .alert("Validation Error", isPresented: $showingValidationAlert) {
            Button("OK") { }
        } message: {
            Text(validationMessage)
        }
    }
    
    private func saveEvent() {
        // Validate form
        if eventName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            validationMessage = "Event name is required"
            showingValidationAlert = true
            return
        }
        
        if eventLocation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            validationMessage = "Event location is required"
            showingValidationAlert = true
            return
        }
        
        if maxAttendees.isEmpty {
            validationMessage = "Max attendees is required"
            showingValidationAlert = true
            return
        }
        
        guard let attendees = Int(maxAttendees), attendees > 0 else {
            validationMessage = "Max attendees must be a positive number"
            showingValidationAlert = true
            return
        }
        
        // Create new event
        let newEvent = Event(
            name: eventName.trimmingCharacters(in: .whitespacesAndNewlines),
            date: eventDate,
            location: eventLocation.trimmingCharacters(in: .whitespacesAndNewlines),
            maxAttendees: attendees,
            description: description.trimmingCharacters(in: .whitespacesAndNewlines),
            isCreatedByUser: true
        )
        
        // Add to events list
        events.append(newEvent)
        
        // Sort events by date (newest first)
        events.sort { $0.date > $1.date }
        
        // Dismiss the sheet
        dismiss()
    }
}

#Preview {
    CreateEventView(events: .constant([]))
} 