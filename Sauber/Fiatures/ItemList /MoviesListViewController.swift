import UIKit
import Combine

final class MoviesListViewController: UIViewController {
    
    //MARK: - Properties
    
    private var viewModel: MoviesListViewModel
    private var subscribers = Set<AnyCancellable>()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupTableView()
        setupBindigs()
    }
    
    //MARK: - Setup
    
    private func setupBindigs() {
        viewModel.isLoading
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.startLoader()
                } else {
                    self?.stopLoader()
                    self?.dismissTableViewViewLoader()
                }
            }.store(in: &subscribers)
        
        viewModel.moviesDidLoadPublisher
            .sink { [weak self] in
                self?.tableView.reloadData()
            }.store(in: &subscribers)
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.addTarget(self, action: #selector(refreshControlValueChanged(sender:)), for: .valueChanged)
    }
    
    @objc private func refreshControlValueChanged(sender: UIRefreshControl) {
        viewModel.refreshData()
    }
    private func dismissTableViewViewLoader() {
        tableView.refreshControl?.endRefreshing()
    }
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "Movies List"
        view.addSubview(tableView)
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
    
    private  func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MoviesListTableViewCell.self,
                           forCellReuseIdentifier: "MoviesListTableViewCell")
    }
}


// MARK: - Table View Data Source And Delegate

extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.recivedMovies.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.recivedMovies.count - 1,
           viewModel.currentPage < viewModel.totalPages {
            viewModel.refreshData()
        }
        
        let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesListTableViewCell", for: indexPath)
        guard let moviesListTableViewCell = cell as? MoviesListTableViewCell else {
            fatalError("Unexpected cell type: \(cell)")
        }
        
        let movie = viewModel.recivedMovies[indexPath.row]
        moviesListTableViewCell.configure(with: movie)
        
        return moviesListTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        let movie = viewModel.recivedMovies[indexPath.row]
        
        navigationController?.pushViewController(MoviesDetailsViewController(viewModel: MoviesDetailsViewModelImpl(selectedMovie: movie)), animated: true)
    }
}
