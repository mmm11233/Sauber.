
import UIKit

final class MoviesListViewController: UIViewController {
    
    //MARK: - Properties
    private let service = Services(networkmanager: NetworkManager())
    private let movies: [MoviesResponse] = []
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupTableView()
        
        service.fetchPopularMovies()
    }
    
    //MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .white
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
    
         func setupTableView() {
             tableView.dataSource = self
             tableView.register(MoviesListTableViewCell.self,
                                forCellReuseIdentifier: "MoviesListTableViewCell")
        }
    }
    
    // MARK: - Table View Data Source And Delegate
    
extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesListTableViewCell", for: indexPath)
        if let MoviesListTableViewCell = cell as? MoviesListTableViewCell {
           return MoviesListTableViewCell
        }
        
        return cell
    }
}
