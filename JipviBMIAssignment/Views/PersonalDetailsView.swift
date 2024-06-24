//import SwiftUI
//
//struct PersonalDetailsView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @ObservedObject var store: PersonalDetailsStore
//
//    @State private var name: String = ""
//    @State private var date: Date = Date()
//    @State private var height: Double?
//    @State private var weight: Double?
//    @State private var navigateToTabBar: Bool = false
//    
//    @State private var nameError: String? = nil
//    @State private var heightError: String? = nil
//    @State private var weightError: String? = nil
//
//    var body: some View {
//        VStack(spacing: 20) {
//            // Name Entry
//            VStack(alignment: .leading, spacing: 5) {
//                Text("Name")
//                    .font(.headline)
//                TextField("Name", text: $name)
//                    .padding()
//                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(nameError == nil ? Color.black : Color.red, lineWidth: 1))
//                    .onChange(of: name) { _ in validateName() }
//
//                if let nameError = nameError {
//                    Text(nameError)
//                        .font(.caption)
//                        .foregroundColor(.red)
//                        .padding(.horizontal)
//                }
//            }
//            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
//            
//            // Date of Birth Entry
//            VStack(alignment: .leading, spacing: 5) {
//                Text("Date of Birth")
//                    .font(.headline)
//                DatePicker("Date of Birth", selection: $date, displayedComponents: .date)
//                    .datePickerStyle(GraphicalDatePickerStyle())
//                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
//            }
//            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
//            
//            // Height Entry
//            VStack(alignment: .leading, spacing: 5) {
//                Text("Height (cm)")
//                    .font(.headline)
//                TextField("Enter your height", value: $height, formatter: NumberFormatter())
//                    .keyboardType(.decimalPad)
//                    .padding()
//                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(heightError == nil ? Color.black : Color.red, lineWidth: 1))
//                    .onChange(of: height) { _ in validateHeight() }
//
//                if let heightError = heightError {
//                    Text(heightError)
//                        .font(.caption)
//                        .foregroundColor(.red)
//                        .padding(.horizontal)
//                }
//            }
//            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
//            
//            // Weight Entry
//            VStack(alignment: .leading, spacing: 5) {
//                Text("Weight (kg)")
//                    .font(.headline)
//                TextField("Enter your weight", value: $weight, formatter: NumberFormatter())
//                    .keyboardType(.decimalPad)
//                    .padding()
//                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(weightError == nil ? Color.black : Color.red, lineWidth: 1))
//                    .onChange(of: weight) { _ in validateWeight() }
//
//                if let weightError = weightError {
//                    Text(weightError)
//                        .font(.caption)
//                        .foregroundColor(.red)
//                        .padding(.horizontal)
//                }
//            }
//            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
//            
//            // Save Button
//            Button(action: saveDetails) {
//                Text("Save and Continue")
//                    .font(.headline)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.red)
//                    .foregroundColor(.white)
//                    .cornerRadius(30)
//            }
//            .padding(.top)
//            
////            NavigationLink(destination: TabBarView(personalDetailsStore: store), isActive: $navigateToTabBar) {
////                            EmptyView()
////                        }
//        }
//        .padding()
//        .navigationBarTitle("Personal Details")
//        .navigationBarTitleDisplayMode(.automatic)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    Image(systemName: "chevron.left")
//                    Text("Back")
//                }
//            }
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
//        if let heightValue = height, heightValue > 0 {
//            heightError = nil
//        } else {
//            heightError = "Please enter a valid height."
//        }
//    }
//
//    private func validateWeight() {
//        if let weightValue = weight, weightValue > 0 {
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
//            let details = PersonalDetails(name: name, date: date, height: height ?? 0.0, weight: weight ?? 0.0)
//            store.personalDetailsList.append(details)
//            navigateToTabBar = true
//        }
//    }
//}
//
//struct PersonalDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonalDetailsView(store: PersonalDetailsStore())
//    }
//}
//
