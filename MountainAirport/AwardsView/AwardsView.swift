import SwiftUI

struct AwardGrid: View {
    var title: String
    var awards: [AwardInformation]
    
    var body: some View {
        Section {
            ForEach(awards, id: \.self) { award in
              NavigationLink(
                destination: AwardDetails(award: award)) {
                AwardCardView(award: award)
                  .foregroundColor(.black)
                  .aspectRatio(0.67, contentMode: .fit)
              }
            }
        } header: {
            Text(title)
                .font(.title)
                .foregroundColor(.white)
        }

    }
}

struct AwardsView: View {
  @EnvironmentObject var flightNavigation: AppEnvironment
  var awardArray: [AwardInformation] {
    flightNavigation.awardList
  }
    
    var activeAwards: [AwardInformation] {
        awardArray.filter { $0.awarded }
    }
    
    var inactiveAwards: [AwardInformation] {
        awardArray.filter { !$0.awarded }
    }
    
    var awardColumns: [GridItem] {
        [GridItem(.adaptive(minimum: 150, maximum: 170))]
    }

  var body: some View {
    ScrollView {
      LazyVGrid(columns: awardColumns) {
        AwardGrid(title: "Awarded", awards: activeAwards)
          AwardGrid(title: "Not Awarded", awards: inactiveAwards)
      }
    }.padding()
    .background(
      Image("background-view")
        .resizable()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    )
    .navigationBarTitle("Your Awards")
  }
}

struct AwardsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      AwardsView()
    }.navigationViewStyle(StackNavigationViewStyle())
    .environmentObject(AppEnvironment())
  }
}
