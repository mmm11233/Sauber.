import UIKit

final class MoviesListViewController: UIViewController {
    
    //MARK: - Properties
  
    private var viewModel: MoviesListViewModel
    
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
    }
    
    //MARK: - Setup
    
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
