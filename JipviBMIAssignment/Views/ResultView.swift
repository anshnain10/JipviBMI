//
//  ResultView.swift
//  JipviBMIAssignment
//
//  Created by ANSH on 23/06/24.
//

import SwiftUI

struct ResultView: View {
    var height: Double
    var weight: Double
    var bmi : Double
    var age : Int
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationStack {
            VStack(alignment: .center,spacing: 30) {
                Text("Your BMI is").bold().font(.title)
                
                VStack(alignment: .center,spacing: 5) {
                    Text(String(format: "%.2f", bmi)).bold().font(.largeTitle)
                    Text("Kg/m2")
                }.padding().background(RoundedRectangle(cornerRadius: 20).fill(Color.red).frame(width: .infinity,height: 100))
                
                Text("(\(bmiCategory))").bold()
                
                
                HStack(alignment: .center,spacing: 60){
                    VStack(alignment: .center,spacing: 10){
                        Text("Age")
                        Text("\(age)")
                    }
                    VStack(alignment: .center,spacing: 10){
                        Text("Height")
                        Text(String(format: "%.0f", height))
                    }
                    VStack(alignment: .center,spacing: 10){
                        Text("Weight")
                        Text(String(format: "%.0f", weight))
                    }
                }.font(.title3).bold().padding().frame(width: .infinity).background(RoundedRectangle(cornerRadius: 20).stroke(.red, lineWidth: 2).fill(Color.white))
                
                VStack(alignment: .trailing,spacing: 20) {
                    Text("A BMI of \(bmiMessage) indicates that your weight is in the \(bmiCategory) category for a person of your height.").padding(.horizontal)
                    
                    Text("Maintaing a healthy weight reduce the risk of diseases associated with overweight and obesity.").padding(.horizontal)
                }.bold().padding(10).multilineTextAlignment(.leading).background(RoundedRectangle(cornerRadius: 20).stroke(.red, lineWidth: 2).fill(Color.white))
            }
            .padding()
            .navigationTitle("Result")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.red, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarBackButtonHidden(true)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    HStack {
//                        Image(systemName: "chevron.left")
//                        Text("Back")
//                    }
//                    .foregroundColor(.black)
//                    .onTapGesture {
//
//                        self.presentationMode.wrappedValue.dismiss()
//                    }
//                }
//            }
        }
    }
    private var bmiCategory: String {
            switch bmi {
            case ..<18.5:
                return "Underweight"
            case 18.5..<25.0:
                return "Normal"
            case 25.0..<30.0:
                return "Overweight"
            default:
                return "Obese"
            }
        }
    private var bmiMessage: String {
            switch bmi {
            case ..<18.5:
                return "less than 18.5"
            case 18.5..<25.0:
                return "18.5-24.9"
            case 25.0..<30.0:
                return "25.0-29.9"
            default:
                return "30.0 and above"
            }
        }
}

#Preview {
    ResultView(height: 171, weight: 81, bmi: 55.4,age: 21)
}
