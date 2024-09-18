import UIKit
import Combine

final class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    private let viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    private let cellId = "HomeTableViewCell"
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private var errorView: UILabel = {
        let errorView = UILabel()
        errorView.backgroundColor = .lightGray
        errorView.textColor = .red
        errorView.isHidden = true
        return errorView
    }()
    
    // MARK: - Initalizer
    
    init(
        viewModel: HomeViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        setupView()
        setupConstraints()
        setupTableView()
        bindViewModel()
    }
    
    //MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(errorView)
        NSLayoutConstraint.activate([
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.widthAnchor.constraint(equalToConstant: 120),
            errorView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$fetchingState
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                switch state {
                case .error(let error):
                    self?.errorView.isHidden = false
                    self?.errorView.text = error.localizedDescription
                default:
                    self?.errorView.isHidden = true
                    self?.tableView.reloadData()
                }
            }
            .store(in: &cancellables)
        
        viewModel.moviesItems
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 12
            ),
            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -12
            ),
            tableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -12
            )
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: cellId)
    }
}
// MARK: - Table View Data Source And Delegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let homeCell = cell as? HomeTableViewCell,
           let movieType = MovieType(rawValue: indexPath.item),
           let movie = viewModel.item(at: indexPath.row, in: movieType) {
            homeCell.configure(with: movie, delegate: self, for: movieType)
        }
        
        return cell
    }
}

extension HomeViewController: HomeTableViewCellDelegate {
    
    func seeAllTapped(for section: MovieType) {
        if section == .movies {
            viewModel.toSelectedItem(section: .movies, from: self)
        } else if section == .series {
            viewModel.toSelectedItem(section: .series, from: self)
        }
    }
    
    func didSelectRowAt(at index: Int) {
        viewModel.didSelectRowAt(at: index, from: self)
    }
}
