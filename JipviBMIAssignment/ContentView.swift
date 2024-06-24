//
//  ContentView.swift
//  JipviBMIAssignment
//
//  Created by ANSH on 22/06/24.
//

import SwiftUI
import FirebaseDatabaseInternal
import FirebaseDatabase

struct ContentView: View {
    @State private var name: String = ""
        @State private var dateOfBirth: Date = Date()
    @State private var height: String = ""
       @State private var weight: String = ""
        @State private var nameError: String? = nil
        @State private var heightError: String? = nil
        @State private var weightError: String? = nil
    @State private var showDetailsView: Bool = false
    @State private var personalDetails: [PersonalDetails] = []
    var body: some View {
        NavigationStack{
            
            ScrollView {
                VStack(spacing: 20) {
                                // Name Entry
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Name")
                                        .font(.headline)
                                    TextField("Enter your name", text: $name)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 10).strokeBorder(nameError == nil ? Color.black : Color.red, lineWidth: 1))
                                        .onChange(of: name) { _ in validateName() }
                                    
                                    if let nameError = nameError {
                                        Text(nameError).font(.caption).foregroundColor(.red)
                                    }
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.white)))
                                
                                // Date of Birth Entry
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Date of Birth")
                                        .font(.headline)
                                    DatePicker("Select your date of birth", selection: $dateOfBirth, displayedComponents: .date)
                                        .datePickerStyle(GraphicalDatePickerStyle())
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.secondarySystemBackground)))
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.white)))
                                
                                // Height Entry
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Height (cm)")
                                        .font(.headline)
                                    TextField("Enter your height", text: $height)
                                        .keyboardType(.decimalPad)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 10).strokeBorder(heightError == nil ? Color.black : Color.red, lineWidth: 1))
                                        .onChange(of: height) { _ in validateHeight() }
                                    
                                    if let heightError = heightError {
                                        Text(heightError).font(.caption).foregroundColor(.red)
                                    }
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.white)))
                                
                                // Weight Entry
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Weight (kg)")
                                        .font(.headline)
                                    TextField("Enter your weight", text: $weight)
                                        .keyboardType(.decimalPad)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 10).strokeBorder(weightError == nil ? Color.black : Color.red, lineWidth: 1))
                                        .onChange(of: weight) { _ in validateWeight() }
                                    
                                    if let weightError = weightError {
                                        Text(weightError).font(.caption).foregroundColor(.red)
                                    }
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                                
                    VStack{
                        Button(action: saveDetails) {
                                            Text("CALCULATE")
                                                .font(.headline)
                                                .frame(maxWidth: .infinity)
                                                .padding()
                                                .background(Color.red)
                                                .foregroundColor(.white)
                                                .cornerRadius(30)
//                            print(personalDetails())
                                        }
                                        .padding(.top)
                        NavigationLink(destination: ResultView(height: Double(height) ?? 0.0, weight: Double(weight) ?? 0.0, bmi: bmi, age: age), isActive: $showDetailsView) {
                                                    EmptyView()
                                                }
                    }
                    
                            }
                            .padding()
                            .navigationTitle("BMI Calculator")
                            .navigationBarTitleDisplayMode(.automatic)
                            .toolbarBackground(Color.red, for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
            }
                    }
                }
   
    private var age: Int {
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: Date())
            return ageComponents.year ?? 0
        }
    private var bmi: Double {
            guard let weightValue = Double(weight), let heightValue = Double(height) else { return 0.0 }
            let heightInMeters = heightValue / 100
            return weightValue / (heightInMeters * heightInMeters)
        }
    private func saveDetails() {
            validateName()
            validateHeight()
            validateWeight()
            
            if nameError == nil && heightError == nil && weightError == nil {
                let newDetails = PersonalDetails(name: name, date: Date(), height: Double(height) ?? 0, weight: Double(weight) ?? 0)
                personalDetails.append(newDetails)
                saveToFirebase(details: newDetails)
                showDetailsView = true
            }
        }
    private func saveToFirebase(details: PersonalDetails) {
            let ref = Database.database().reference().child("personalDetails").childByAutoId()
            ref.setValue(details.dictionary) { error, _ in
                if let error = error {
                    print("Error saving details: \(error.localizedDescription)")
                } else {
                    print("Details saved successfully.")
                }
            }
        }
                private func validateName() {
                    if name.isEmpty {
                        nameError = "Name cannot be empty."
                    } else {
                        nameError = nil
                    }
                }

                private func validateHeight() {
                    if let heightValue = Double(height), heightValue > 0 {
                        heightError = nil
                    } else {
                        heightError = "Please enter a valid height."
                    }
                }

                private func validateWeight() {
                    if let weightValue = Double(weight), weightValue > 0 {
                        weightError = nil
                    } else {
                        weightError = "Please enter a valid weight."
                    }
                }
            
        }
    

#Preview {
    ContentView()
}

//import SwiftUI
//
//struct ContentView: View {
//    @State private var name: String = ""
//    @State private var dateOfBirth: Date = Date()
//    @State private var height: String = ""
//    @State private var weight: String = ""
//    
//    @State private var nameError: String? = nil
//    @State private var heightError: String? = nil
//    @State private var weightError: String? = nil
//    
//    @State private var showDetailsView: Bool = false
//    
//    var body: some View {
//        NavigationView {
//            ScrollView{
//                VStack(spacing: 20) {
//                    // Name Entry
//                    VStack(alignment: .leading, spacing: 5) {
//                        Text("Name")
//                            .font(.headline)
//                        TextField("Enter your name", text: $name)
//                            .padding()
//                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(nameError == nil ? Color.blue : Color.red, lineWidth: 1))
//                            .onChange(of: name) { _ in validateName() }
//                        
//                        if let nameError = nameError {
//                            Text(nameError).font(.caption).foregroundColor(.red)
//                        }
//                    }
//                    .padding()
//                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
//                    
//                    // Date of Birth Entry
//                    VStack(alignment: .leading, spacing: 5) {
//                        Text("Date of Birth")
//                            .font(.headline)
//                        DatePicker("Select your date of birth", selection: $dateOfBirth, displayedComponents: .date)
//                            .datePickerStyle(GraphicalDatePickerStyle())
//                            .padding()
//                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
//                    }
//                    .padding()
//                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
//                    
//                    // Height Entry
//                    VStack(alignment: .leading, spacing: 5) {
//                        Text("Height (cm)")
//                            .font(.headline)
//                        TextField("Enter your height", text: $height)
//                            .keyboardType(.decimalPad)
//                            .padding()
//                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(heightError == nil ? Color.blue : Color.red, lineWidth: 1))
//                            .onChange(of: height) { _ in validateHeight() }
//                        
//                        if let heightError = heightError {
//                            Text(heightError).font(.caption).foregroundColor(.red)
//                        }
//                    }
//                    .padding()
//                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
//                    
//                    // Weight Entry
//                    VStack(alignment: .leading, spacing: 5) {
//                        Text("Weight (kg)")
//                            .font(.headline)
//                        TextField("Enter your weight", text: $weight)
//                            .keyboardType(.decimalPad)
//                            .padding()
//                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(weightError == nil ? Color.blue : Color.red, lineWidth: 1))
//                            .onChange(of: weight) { _ in validateWeight() }
//                        
//                        if let weightError = weightError {
//                            Text(weightError).font(.caption).foregroundColor(.red)
//                        }
//                    }
//                    .padding()
//                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
//                    
//                    // Save Button
//                    Button(action: saveDetails) {
//                        Text("Save")
//                            .font(.headline)
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.red)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//                    .padding(.top)
//                    
//                    Spacer()
//                    
//                    // Navigation Link to Details View
//                    NavigationLink(destination: DetailsView(name: name, dateOfBirth: dateOfBirth, height: height, weight: weight), isActive: $showDetailsView) {
//                        EmptyView()
//                    }
//                }
//            }
//            .padding()
//            .navigationBarTitle("User Details", displayMode: .inline)
//        }
//    }
//    
//    private func validateName() {
//        if name.isEmpty {
//            nameError = "Name cannot be empty."
//        } else {
//            nameError = nil
//        }
//    }
//
//    private func validateHeight() {
//        if let heightValue = Double(height), heightValue > 0 {
//            heightError = nil
//        } else {
//            heightError = "Please enter a valid height."
//        }
//    }
//
//    private func validateWeight() {
//        if let weightValue = Double(weight), weightValue > 0 {
//            weightError = nil
//        } else {
//            weightError = "Please enter a valid weight."
//        }
//    }
//
//    private func saveDetails() {
//        validateName()
//        validateHeight()
//        validateWeight()
//        
//        if nameError == nil && heightError == nil && weightError == nil {
//            showDetailsView = true
//        }
//    }
//}
//
//struct DetailsView: View {
//    var name: String
//    var dateOfBirth: Date
//    var height: String
//    var weight: String
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Details")
//                .font(.largeTitle)
//                .padding(.bottom, 20)
//            
//            HStack {
//                Text("Name:")
//                Spacer()
//                Text(name)
//            }
//            .padding()
//            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
//            
//            HStack {
//                Text("Date of Birth:")
//                Spacer()
//                Text(dateFormatter.string(from: dateOfBirth))
//            }
//            .padding()
//            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
//            
//            HStack {
//                Text("Height (cm):")
//                Spacer()
//                Text(height)
//            }
//            .padding()
//            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
//            
//            HStack {
//                Text("Weight (kg):")
//                Spacer()
//                Text(weight)
//            }
//            .padding()
//            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
//            
//            Spacer()
//        }
//        .padding()
//        .navigationBarTitle("Details", displayMode: .inline)
//    }
//    
//    private var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        return formatter
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
