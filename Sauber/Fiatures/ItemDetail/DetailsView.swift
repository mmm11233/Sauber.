import SwiftUI

struct DetailsView: View {
    let movie: ItemModel

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "\(EndpointRepository.imageBaseURL)\(movie.posterPath ?? "")")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 300)
            } placeholder: {
                ProgressView()
            }
            Text(movie.originalTitle ?? "")
                .font(.title)
                .padding()
            
        }
        .navigationTitle(movie.originalTitle ?? "Details")
    }
}


