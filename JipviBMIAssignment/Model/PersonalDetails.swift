
//  PersonalDetails.swift
//  JipviBMIAssignment
//
//  Created by ANSH on 23/06/24.
//

import SwiftUI

struct PersonalDetails: Identifiable,Codable {
    var id = UUID()
    var name: String
    var date: Date
    var height: Double
    var weight: Double
    
    var dictionary: [String: Any] {
        return [
            "name": name,
            "date": date.timeIntervalSince1970,
            "height": height,
            "weight": weight
        ]
    }
}
