import SwiftUI

struct DetailsView: View {
    let movie: ItemModel
    
    var body: some View {
        AsyncImage(url: URL(string: "\(EndpointRepository.imageBaseURL)\(movie.posterPath ?? "")")) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200, maxHeight: 300)
        } placeholder: {
            ProgressView()
        }
        ScrollView() {
            ItemsView
        }
        .navigationTitle(movie.originalTitle ?? "Details")
    }
    
    private var ItemsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(movie.originalTitle ?? "Unknown Title")
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
            
            Text("Popularity - \(movie.popularity)")
                .font(.system(size: 20, weight: .medium))
                .padding(.bottom, 16)
            
            Text(movie.overview ?? "No overview available")
                .font(.system(size: 18, weight: .regular))
                .padding(.bottom, 24)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal)
    }
}
