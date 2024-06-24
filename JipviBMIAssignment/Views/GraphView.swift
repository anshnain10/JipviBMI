import SwiftUI
import SwiftUICharts
import Firebase
import FirebaseDatabase

struct GraphView: View {
    @StateObject private var viewModel = PersonalDetailsViewModel()
    private var db = Database.database().reference()

    var body: some View {
        NavigationStack {
            VStack {
                Text("Weight Changes Over the Past Week")
                    .font(.headline)
                    .padding()
                
                if viewModel.personalDetails.isEmpty {
                    Text("No data available")
                        .foregroundColor(.gray)
                } else {
                    LineChartView(data: viewModel.personalDetails.map { $0.weight },
                                  title: "Weight (kg)",
                                  legend: "Last 7 days",
                                  form: ChartForm.extraLarge,
                                  dropShadow: true,
                                  valueSpecifier: "%.1f")
                        .padding()
                        .overlay(
                            GeometryReader { geo in
                                ZStack {
                                    ForEach(viewModel.personalDetails) { detail in
                                        Circle()
                                            .fill(Color.purple)
                                            .frame(width: 118, height: 8)
                                            .position(x: geo.size.width * CGFloat(self.xPosition(for: detail.date)),
                                                      y: geo.size.height * CGFloat(self.yPosition(for: detail.weight)))
                                            .padding(5)
                                    }
                                }
                            }
                        ).padding(.all)
                }
            }
            .padding()
            .navigationBarTitle("Weight Graph", displayMode: .inline)
            .toolbarBackground(Color.red, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .onAppear {
            viewModel.fetchPersonalDetails()
        }
    }

    private func xPosition(for date: Date) -> Double {
        let calendar = Calendar.current
        let daysAgo = calendar.dateComponents([.day], from: date, to: Date()).day ?? 0
        return Double(daysAgo) / 6.0
    }
    
    private func yPosition(for weight: Double) -> Double {
        return (100.0 - weight) / 100.0
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleData = [
            PersonalDetails(name: "String", date: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, height: 170, weight: 70),
            PersonalDetails(name: "String", date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, height: 170, weight: 71),
            PersonalDetails(name: "String", date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, height: 170, weight: 69),
            PersonalDetails(name: "String", date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, height: 170, weight: 68),
            PersonalDetails(name: "String", date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, height: 170, weight: 70),
            PersonalDetails(name: "String", date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, height: 170, weight: 72),
            PersonalDetails(name: "String", date: Date(), height: 170, weight: 70)
        ]

        GraphView()
    }
}
