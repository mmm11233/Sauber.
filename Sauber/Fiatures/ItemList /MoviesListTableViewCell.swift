import UIKit

final class MoviesListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var moviesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .darkGray
        label.text = ""
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints =  false
        return label
    }()
    
    private var moviesRatingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkGray
        label.text = "Rating - "
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints =  false
        return label
    }()
    
    private var moviesOverviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints =  false
        return label
    }()
    
    private var moviesImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "red")
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setUpSubView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Prepare For Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        moviesTitleLabel.text = nil
        moviesOverviewLabel.text = nil
    }
    
    // MARK: - Configuration
    func configure(with model: Movie) {
        moviesTitleLabel.text = model.originalTitle
        moviesRatingLabel.text = "Rating - \(model.popularity)"
        moviesOverviewLabel.text = model.overview
        moviesImage.loadImageUsingCacheWithURL(posterPath: model.posterPath)
    }
    
    // MARK: - Setup
    
    private func setUpSubView() {
        addSubview(moviesTitleLabel)
        addSubview(moviesRatingLabel)
        addSubview(moviesOverviewLabel)
        addSubview(moviesImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            moviesTitleLabel.topAnchor.constraint(
                equalTo: moviesImage.topAnchor),
            moviesTitleLabel.leadingAnchor.constraint(
                equalTo: moviesImage.trailingAnchor,
                constant: 12),
            moviesTitleLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: 12),
            
            moviesRatingLabel.topAnchor.constraint(
                equalTo: moviesTitleLabel.bottomAnchor,
                constant: 10),
            moviesRatingLabel.leadingAnchor.constraint(
                equalTo: moviesImage.trailingAnchor,
                constant: 12),
            moviesRatingLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: 12),
            moviesOverviewLabel.topAnchor.constraint(
                equalTo: moviesRatingLabel.bottomAnchor,
                constant: 10),
            moviesOverviewLabel.leadingAnchor.constraint(
                equalTo: moviesImage.trailingAnchor,
                constant: 12),
            moviesOverviewLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: 12),
            moviesOverviewLabel.bottomAnchor
                .constraint(equalTo: moviesImage.bottomAnchor),
            
            
            moviesImage.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: 10),
            moviesImage.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 10),
            moviesImage.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -12),
            moviesImage.heightAnchor.constraint(
                equalToConstant: 200),
            moviesImage.widthAnchor.constraint(
                equalToConstant: 140)
        ])
    }
}
