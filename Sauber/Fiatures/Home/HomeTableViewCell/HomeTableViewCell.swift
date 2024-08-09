import UIKit

final class HomeTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private var moviesGenreName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura Condensed Medium", size: 40)
        label.textColor = .darkGray
        label.text = "Top rated"
        label.translatesAutoresizingMaskIntoConstraints =  false
        
        return label
    }()
    
    private var allMoviesButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "See all"
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    //MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .yellow
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Prepare For Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        moviesGenreName.text = nil
    }
    
    //MARK: - setupView
    private func setupView() {
        addSubview(moviesGenreName)
        addSubview(allMoviesButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            moviesGenreName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            moviesGenreName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            allMoviesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            moviesGenreName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            allMoviesButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            allMoviesButton.widthAnchor.constraint(equalToConstant: 150),
            allMoviesButton.heightAnchor.constraint(equalToConstant: 50),
            
            allMoviesButton.leadingAnchor.constraint(equalTo: moviesGenreName.trailingAnchor, constant: 48)

        ])
    }
}



