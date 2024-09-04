import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    
    private var movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "red")
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var movieName: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "Peaky Blinders"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - setupView
    
    private func setupView() {
        addSubview(movieImage)
        addSubview(movieName)
    }
    
    func configure(with model: Movie) {
        movieName.text = model.originalName
        movieImage.image = model.posterPath?.image
        if let posterPath = model.posterPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            movieImage.loadImage(from: url)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 150),
            movieImage.widthAnchor.constraint(equalToConstant: 100),
            
            movieName.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -10),
            movieName.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: 10),
            movieName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}


public extension String {
    var image: UIImage? { get { return UIImage(named: self) } }
}
