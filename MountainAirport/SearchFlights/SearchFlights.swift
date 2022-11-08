import SwiftUI

struct SearchFlights: View {
  @State var flightData: [FlightInformation]
  @State private var date = Date()
  @State private var directionFilter: FlightDirection = .none
  @State private var city = ""
  @State private var runningSearch = false

  var matchingFlights: [FlightInformation] {
    var matchingFlights = flightData

    if directionFilter != .none {
      matchingFlights = matchingFlights.filter {
        $0.direction == directionFilter
      }
    }
    return matchingFlights
  }

  var flightDates: [Date] {
    let allDates = matchingFlights.map { $0.localTime.dateOnly }
    let uniqueDates = Array(Set(allDates))
    return uniqueDates.sorted()
  }

  func flightsForDay(date: Date) -> [FlightInformation] {
    matchingFlights.filter {
      Calendar.current.isDate($0.localTime, inSameDayAs: date)
    }
  }

  var body: some View {
    ZStack {
      Image("background-view")
        .resizable()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      VStack {
        Picker(
          selection: $directionFilter,
          label: Text("Flight Direction")) {
          Text("All").tag(FlightDirection.none)
          Text("Arrivals").tag(FlightDirection.arrival)
          Text("Departures").tag(FlightDirection.departure)
        }
        .background(Color.white)
        .pickerStyle(SegmentedPickerStyle())
        List {
          ForEach(flightDates, id: \.hashValue) { date in
            Section(
              header: Text(longDateFormatter.string(from: date)),
              footer:
                HStack {
                  Spacer()
                  Text("Matching flights \(flightsForDay(date: date).count)")
                }
            ) {
              ForEach(flightsForDay(date: date)) { flight in
                SearchResultRow(flight: flight)
              }
            }
          }
        }
        .overlay(
          Group {
            if runningSearch {
              VStack {
                Text("Searching...")
                ProgressView()
                  .progressViewStyle(CircularProgressViewStyle())
                  .tint(.black)
              }
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .background(.white)
              .opacity(0.8)
            }
          }
        )
        .listStyle(InsetGroupedListStyle())
        Spacer()
      }
      .searchable(text: $city, prompt: "City Name") {
        // 1
        ForEach(FlightData.citiesContaining(city), id: \.self) { city in
          // 2
          Text(city).searchCompletion(city)
        }
      }
      // 1
      .onSubmit(of: .search) {
        Task {
          runningSearch = true
          await flightData = FlightData.searchFlightsForCity(city)
          runningSearch = false
        }
      }
      .onChange(of: city) { newText in
        if newText.isEmpty {
          Task {
            runningSearch = true
            await flightData = FlightData.searchFlightsForCity(city)
            runningSearch = false
          }
        }
      }
      .navigationBarTitle("Search Flights")
      .padding()
    }
  }
}

struct SearchFlights_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SearchFlights(flightData: FlightData.generateTestFlights(date: Date())
      )
    }
  }
}
