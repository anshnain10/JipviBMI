//
//  DetailsView.swift
//  JipviBMIAssignment
//
//  Created by ANSH on 23/06/24.
//

import SwiftUI

struct DetailsView: View {
    var name: String
    var dateOfBirth: Date
    var height: String
    var weight: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                
                
                HStack {
                    Text("Name:")
                    Spacer()
                    Text(name)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                
                HStack {
                    Text("Date of Birth:")
                    Spacer()
                    Text(dateFormatter.string(from: dateOfBirth))
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                
                HStack {
                    Text("Height (cm):")
                    Spacer()
                    Text(height)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                
                HStack {
                    Text("Weight (kg):")
                    Spacer()
                    Text(weight)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                
                Spacer()
            }
            
            .padding()
            .navigationBarTitle("Details", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.black)
                    .onTapGesture {
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

#Preview {
    DetailsView(name: "ansh", dateOfBirth: Date(), height: "171", weight: "71")
}
