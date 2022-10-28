import SwiftUI

struct FlightStatusBoard: View {
    var flights: [FlightInformation]
    @State private var hidePast: Bool = false
    @AppStorage("FlightStatusCurrentTab") var selectedTab = 1
    var shownFlights: [FlightInformation] {
        hidePast ?
        flights.filter { $0.localTime >= Date() } :
        flights
    }
    var shortDateString: String {
        let dateF = DateFormatter()
        dateF.timeStyle = .none
        dateF.dateFormat = "MMM d"
        return dateF.string(from: Date())
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            FlightList(
                flights: shownFlights.filter { $0.direction == .arrival }
            ).tabItem {
                Image("descending-airplane")
                    .resizable()
                Text("Arrivals")
            }
            .badge(shownFlights.filter { $0.direction == .arrival }.count)
            .tag(0)
            FlightList(
                flights: shownFlights
            ).tabItem {
                Image(systemName: "airplane")
                    .resizable()
                Text("All")
            }
            .badge(shortDateString)
            .tag(1)
            FlightList(
                flights: shownFlights.filter { $0.direction == .departure }
            ).tabItem {
                Image("ascending-airplane")
                Text("Departures")
            }
            .badge(shownFlights.filter { $0.direction == .departure }.count)
            .tag(2)
        }.navigationTitle("Flight Status")
            .navigationBarItems(
                trailing: Toggle(
                    "Hide Past",
                    isOn: $hidePast
                )
            )
    }
}

struct FlightStatusBoard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FlightStatusBoard(flights: FlightData.generateTestFlights(date: Date()))
        }
    }
}
