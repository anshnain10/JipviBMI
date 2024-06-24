//
//  PersonalDetailStore.swift
//  JipviBMIAssignment
//
//  Created by ANSH on 24/06/24.
//
import Foundation
import Combine
import FirebaseDatabase

class PersonalDetailStore: ObservableObject {
    @Published var weightDataForPastWeek: [PersonalDetails] = []

    private var db = Database.database().reference()

    init() {
        fetchWeightDataForPastWeek()
    }

    func fetchWeightDataForPastWeek() {
        let startDate = Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date()
        let endDate = Date()

        db.child("personalDetails")
            .queryOrdered(byChild: "date")
            .queryStarting(atValue: startDate.timeIntervalSince1970 * 1000) // Firebase expects milliseconds
            .queryEnding(atValue: endDate.timeIntervalSince1970 * 1000)
            .observeSingleEvent(of: .value) { snapshot in
                var weights: [PersonalDetails] = []
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                       let dict = snapshot.value as? [String: Any],
                       let name = dict["name"] as? String,
                       let dateInterval = dict["date"] as? TimeInterval,
                       let height = dict["height"] as? Double,
                       let weight = dict["weight"] as? Double {

                        let date = Date(timeIntervalSince1970: dateInterval)
                        let detail = PersonalDetails(name: name, date: date, height: height, weight: weight)
                        weights.append(detail)
                    }
                }
                self.weightDataForPastWeek = weights
            }
    }
}
