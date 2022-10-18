import SwiftUI

struct WelcomeButtonView: View {
    // MARK: - Properties
    var title: String
    var subTitle: String
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .foregroundColor(.white)
            Text(subTitle)
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Image("link-pattern")
                .resizable()
                .clipped()
        )
    }
}

// MARK: - Preview
struct WelcomeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeButtonView(title: "Flight Status", subTitle: "Departure and arrival information")
    }
}
