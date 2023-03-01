import SwiftUI

struct SearchView: View {

    private let searchResults = [
        "The femur is the longest and largest bone in the human body.",
        "The moon is 238,900 miles away.",
        "Prince’s last name was Nelson.",
        "503 new species were discovered in 2020.",
        "Ice is 9 percent less dense than liquid water.",
        "You can spell every number up to 1,000 without using the letter A.\n\n...one, two, three, four...ninety-nine...nine hundred ninety-nine 🧐",
        "A collection of hippos is called a bloat.",
        "White sand beaches are made of parrotfish poop.",
    ]
    
    @State private var result = "touch search button!"
    var body: some View {
        VStack {
            Text(result)
                .padding()
                .font(.title)
                .frame(minHeight: 400)

            Button("Show Random Search") {
                result = searchResults.randomElement()!
            }
        }
        .padding()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
