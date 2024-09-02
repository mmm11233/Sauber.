import UIKit

final class MoviesDetailsViewController: UIViewController {
    // MARK: - Properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let scrollViewContent: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        
        return uiView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let imageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "red")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        label.text = "Init"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.text = "Types of Init"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = "Designated Initializers: Main initializers that ensure all properties are initialized and call the superclass initializer.Convenience Initializers: Secondary initializers that provide additional ways to initialize a class, calling another initializer within the same class.Required Initializers: Enforced initializers that must be implemented by subclasses, often used in protocol conformance.ravici meti swiftze vwer cods  esignated Initializers: Main initializers that ensure all properties are initialized and call the superclass initializer.Convenience Initializers: Secondary initializers that provide additional ways to initialize a class, calling another initializer within the same class.Required Initializers: Enforced initializers that must be implemented by subclasses, often used in protocol conformance"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var viewModel: MoviesDetailViewModel
    
    
    // MARK: - Initalizer
    
    init(viewModel: MoviesDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Details"
        setupView()
        addSubviews()
        setupContraints()
        configureViews()
    }
    
    // MARK: - Configuration
    
    private func configureViews() {
        //        if let imageURL = URL(string: viewModel.selectedDish.pictureURL) {
        //            startLoading()
        //
        //            downloadImage(from: imageURL)
        titleLabel.text = viewModel.getTitle()
        subTitleLabel.text = viewModel.getSubtitle()
        descriptionLabel.text = viewModel.getDescription()
    }

//MARK: - setupView

private func setupView() {
    navigationController?.navigationBar.prefersLargeTitles = false
}

private func addSubviews() {
    view.addSubview(scrollView)
    scrollView.addSubview(scrollViewContent)
    scrollViewContent.addSubview(imageView)
    scrollViewContent.addSubview(stackView)
    
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(subTitleLabel)
    stackView.addArrangedSubview(descriptionLabel)
}

private func setupContraints() {
    NSLayoutConstraint.activate([
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        scrollViewContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
        scrollViewContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        scrollViewContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
        scrollViewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        scrollViewContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        
        imageView.leadingAnchor.constraint(equalTo: scrollViewContent.leadingAnchor),
        imageView.trailingAnchor.constraint(equalTo: scrollViewContent.trailingAnchor),
        imageView.topAnchor.constraint(equalTo: scrollViewContent.topAnchor),
        imageView.heightAnchor.constraint(equalToConstant: view.frame.width),
        
        stackView.leadingAnchor.constraint(equalTo: scrollViewContent.leadingAnchor, constant: 16),
        stackView.trailingAnchor.constraint(equalTo: scrollViewContent.trailingAnchor, constant: -16),
        stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 34),
        stackView.bottomAnchor.constraint(equalTo: scrollViewContent.bottomAnchor)
    ])
}
}
