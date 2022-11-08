import SwiftUI

struct FlightList: View {
  var flights: [FlightInformation]
  @Binding var highlightedIds: [Int]

  func rowHighlighted(_ flightId: Int) -> Bool {
    return highlightedIds.contains { $0 == flightId }
  }

  var nextFlightId: Int {
    guard let flight = flights.first(
      where: {
        $0.localTime >= Date()
      }
    ) else {
      // swiftlint:disable:next force_unwrapping
      return flights.last!.id
    }
    return flight.id
  }

  var body: some View {
    ScrollViewReader { scrollProxy in
      List(flights) { flight in
        NavigationLink(
          destination: FlightDetails(flight: flight)) {
          FlightRow(flight: flight)
        }
        .listRowBackground(
          rowHighlighted(flight.id) ? Color.yellow.opacity(0.6) : Color.clear
        )
        // 1
        .swipeActions(edge: .leading) {
          // 2
          HighlightActionView(flightId: flight.id, highlightedIds: $highlightedIds)
        }
      }.onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
          scrollProxy.scrollTo(nextFlightId, anchor: .center)
        }
      }
    }
  }
}

struct FlightList_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FlightList(
        flights: FlightData.generateTestFlights(date: Date()),
        highlightedIds: .constant([15])
      )
    }
  }
}
