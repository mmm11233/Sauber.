import UIKit
import Combine

final class HomeViewController: UIViewController {
    
    //MARK: - Properties
    private let viewModel: HomeViewModel
    private var cancalable = Set<AnyCancellable>()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        setupView()
        setupConstraints()
        setupTableView()
        setupBindigs()
        viewModel.fetchMoviesAndSerials()
    }
    
    //MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func setupBindigs() {
        viewModel.moviesDidLoadPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.tableView.reloadData()
            }
            .store(in: &cancalable)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate ([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10),
            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 12),
            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -12),
            tableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -12)
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
    }
    
}
// MARK: - Table View Data Source And Delegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath)
        if let homeCell = cell as? HomeTableViewCell,
           let movie = viewModel.item(at: indexPath.row, in: indexPath.item) {
            homeCell.configure(with: movie, delegate: self, section: indexPath.item)
        }
        
        return cell
    }
}


extension HomeViewController: HomeTableViewCellDelegate {
    func seeAllTapped(in section: Int) {
        if section == 0 {
            viewModel.movies(section: section, from: self)
        }
        else if section == 1 {
            viewModel.serials(section: section, from: self)
        }
        else {
            return 
        }
    }
    
    func didSelectRowAt(at index: Int) {
        viewModel.didSelectRowAt(at: index, from: self)
    }
}
