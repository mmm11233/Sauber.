import UIKit

protocol HomeTableViewCellDelegate: AnyObject {
    func didSelectRowAt(at index: Int)
}

final class HomeTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private var model: HomeTableViewCellModel?
    private weak var delegate: HomeTableViewCellDelegate?
    
    private var moviesGenreName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.text = ""
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
    
    func configure(with model: HomeTableViewCellModel, delegate: HomeTableViewCellDelegate) {
        self.delegate = delegate
        self.model = model
        moviesGenreName.text = model.moviesResponse.results.first?.name
        
        collectionView.reloadData()
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
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            moviesGenreName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            moviesGenreName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            moviesGenreName.trailingAnchor.constraint(equalTo: allMoviesButton.leadingAnchor, constant: -12),
            moviesGenreName.bottomAnchor.constraint(equalTo: allMoviesButton.bottomAnchor),
            
            
            allMoviesButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            allMoviesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            collectionView.topAnchor.constraint(equalTo: moviesGenreName.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            collectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model?.moviesResponse.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath)
        if let HomeCollectionViewControllerCell = cell as? HomeCollectionViewCell,
           let movie = model?.moviesResponse.results[indexPath.row] {
            HomeCollectionViewControllerCell.configure(with: movie)
            
            return HomeCollectionViewControllerCell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: 100, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectRowAt(at: indexPath.row)
    }
}
