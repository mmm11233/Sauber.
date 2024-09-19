import UIKit

//MARK: - Home Table View Cell Delegate

protocol HomeTableViewCellDelegate: AnyObject {
    func seeAllTapped(for section: MovieType)
    func didSelectRowAt(at indexPath: Int, section: MovieType)
}

final class HomeTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private var model: [ItemModel]? = []
    private weak var detailsDelegate: HomeTableViewCellDelegate?
    private var section: MovieType?
    private var cellId = "HomeCollectionViewCell"
    
    private var moviesGenreName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .darkGray
        label.text = "Top rated"
        label.translatesAutoresizingMaskIntoConstraints =  false
        return label
    }()
    
    private var allMoviesButton: UIButton = {
        let button = UIButton()
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
        button.titleLabel?.attributedText = underlineAttributedString
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    //MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setupView()
        setupConstraints()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Prepare For Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        moviesGenreName.text = nil
    }
    
    // MARK: - Configuration
    func configure(with model: [ItemModel], delegate: HomeTableViewCellDelegate, for section: MovieType) {
        self.detailsDelegate = delegate
        self.model = model
        self.section = section
        
        switch section {
        case .movies:
            moviesGenreName.text = "Movies"
        case .series:
            moviesGenreName.text = "Serials"
        }
        collectionView.reloadData()
    }
    
    @objc func buttonClicked(sender : UIButton){
        if section == MovieType.movies {
            detailsDelegate?.seeAllTapped(for: .movies)
        } else if section == MovieType.series {
            detailsDelegate?.seeAllTapped(for: .series)
        }
    }
    
    //MARK: - setupView
    private func setupView() {
        contentView.addSubview(moviesGenreName)
        contentView.addSubview(allMoviesButton)
        contentView.addSubview(collectionView)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCell.self,
                                forCellWithReuseIdentifier: cellId)
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            moviesGenreName.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 12
            ),
            moviesGenreName.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 12
            ),
            moviesGenreName.trailingAnchor.constraint(
                equalTo: allMoviesButton.leadingAnchor,
                constant: -12
            ),
            moviesGenreName.bottomAnchor.constraint(
                equalTo: allMoviesButton.bottomAnchor
            ),
            
            allMoviesButton.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: 12
            ),
            allMoviesButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -12
            ),
            
            collectionView.topAnchor.constraint(
                equalTo: moviesGenreName.bottomAnchor,
                constant: 12
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 12
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -12
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -12
            ),
            collectionView.heightAnchor.constraint(
                equalToConstant: 150
            )
        ])
    }
}


extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        if let homeCollectionViewCell = cell as? HomeCollectionViewCell,
           let model = model,
           indexPath.row < model.count {
            
            let movie = model[indexPath.row]
            homeCollectionViewCell.configure(with: movie)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: 100, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch section {
        case .movies:
            detailsDelegate?.didSelectRowAt(at: indexPath.row, section: .movies)
        case .series:
            detailsDelegate?.didSelectRowAt(at: indexPath.row, section: .series)
        case .none:
            break
        }
    }
}
