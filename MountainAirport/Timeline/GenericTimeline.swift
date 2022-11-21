import SwiftUI

struct GenericTimeline<Content, T>: View where Content: View {
    // MARK: - Properties
    let events: [T]
    let content: (T) -> Content
    let timePropery: KeyPath<T, Date>
    
    init(events: [T],
         timeProperty: KeyPath<T, Date>,
         @ViewBuilder content: @escaping (T) -> Content) {
        self.events = events
        self.timePropery = timeProperty
        self.content = content
    }
    
    var earliestHour: Int {
        let flightAscending = events.sorted {
            $0[keyPath: timePropery] < $1[keyPath: timePropery]
        }
        guard let firstFlight = flightAscending.first else { return 0 }
        let hour = Calendar.current.component(.hour, from: firstFlight[keyPath: timePropery])
        return hour
    }
    
    var latesttHour: Int {
        let flightAscending = events.sorted {
            $0[keyPath: timePropery] > $1[keyPath: timePropery]
        }
        guard let firstFlight = flightAscending.first else { return 24 }
        let hour = Calendar.current.component(.hour, from: firstFlight[keyPath: timePropery])
        return hour + 1
    }
    
    func eventsInHour(_ hour: Int) -> [T] {
        return events.filter {
            let flightHour = Calendar.current.component(.hour, from: $0[keyPath: timePropery])
            return flightHour == hour
        }
    }
    
    func hourString(_ hour: Int) -> String {
        let tcmp = DateComponents(hour: hour)
        if let time = Calendar.current.date(from: tcmp) {
            return shortTimeFormatter.string(from: time)
        }
        return "Unknown"
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack {
                ForEach(earliestHour..<latesttHour) { hour in
                    let hourFlights = eventsInHour(hour)
                    Text(hourString(hour))
                        .font(.title2)
                    ForEach(hourFlights.indices) { index in
                        content(hourFlights[index])
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct GenericTimeline_Previews: PreviewProvider {
    static var previews: some View {
        GenericTimeline(events: FlightData.generateTestFlights(date: Date()),
                        timeProperty: \.localTime) {
            flight in
                FlightCardView(flight: flight)
        }
    }
}
