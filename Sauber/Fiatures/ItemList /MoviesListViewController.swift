import UIKit
import Combine

final class MoviesListViewController: UIViewController {
    
    //MARK: - Properties
    
    private var viewModel: MoviesListViewModel
    private var cancellables = Set<AnyCancellable>()
    private let cellId = "MoviesListTableViewCell"
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
        viewModel: MoviesListViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.itemType.title
        setupView()
        setupConstraints()
        setupTableView()
        bindViewModel()
    }
    
    //MARK: - Setup
    
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
        
        viewModel.moviesDidLoadPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "Movies List"
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate ([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            tableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
    
    private  func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MoviesListTableViewCell.self,
                           forCellReuseIdentifier: cellId)
    }
}

// MARK: - Table View Data Source And Delegate

extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.items.count - 1,
           viewModel.currentPage < viewModel.totalPages {
            viewModel.refreshData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        guard let moviesListTableViewCell = cell as? MoviesListTableViewCell else {
            fatalError("Unexpected cell type: \(cell)")
        }
        
        let movie = viewModel.items[indexPath.row]
        moviesListTableViewCell.configure(with: movie)
        
        return moviesListTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        let movie = viewModel.items[indexPath.row]
        
        navigationController?.pushViewController(MoviesDetailsViewController(viewModel: MoviesDetailsViewModelImpl(selectedMovie: movie)), animated: true)
    }
}
