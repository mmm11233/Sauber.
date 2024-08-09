import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    
    private var movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "multiply.circle.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var movieName: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "Drakula"
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
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
}
