//
//  PersonalDetailsViewModel.swift
//  JipviBMIAssignment
//
//  Created by ANSH on 24/06/24.
//
import SwiftUI
import Firebase
import FirebaseDatabase

class PersonalDetailsViewModel: ObservableObject {
    @Published var personalDetails: [PersonalDetails] = []

    private var db = Database.database().reference()

    init() {
        fetchPersonalDetails()
    }

    func fetchPersonalDetails() {
        db.child("personalDetails").observe(.value) { snapshot in
            var details: [PersonalDetails] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let dict = snapshot.value as? [String: Any],
//                   let id = dict["id"] as? String,
                   let name = dict["name"] as? String,
                   let dateInterval = dict["date"] as? TimeInterval,
                   let height = dict["height"] as? Double,
                   let weight = dict["weight"] as? Double {
                    
                    let date = Date(timeIntervalSince1970: dateInterval)
                    let detail = PersonalDetails(name: name, date: date, height: height, weight: weight)
                    details.append(detail)
                }
            }
            self.personalDetails = details
        }
    }
}
