import UIKit
<<<<<<< HEAD
import Combine

final class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    private let viewModel: HomeViewModel
    private var cancalable = Set<AnyCancellable>()
    
=======

final class HomeViewController: UIViewController {
    //MARK: - Properties
    
>>>>>>> main
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
<<<<<<< HEAD
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
        
=======
    //MARK: - LifeCycle
    
>>>>>>> main
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        setupView()
        setupConstraints()
        setupTableView()
<<<<<<< HEAD
        setupBindigs()
    }
    
    //MARK: - Setup
    //private extension gavaketo
=======
    }
    
    //MARK: - Setup
    
>>>>>>> main
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
<<<<<<< HEAD
    private func setupBindigs() {
        viewModel.moviesDidLoadPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.tableView.reloadData()
            }
            .store(in: &cancalable)
    }
    
    private func setupConstraints() {
        //not coorrect
        NSLayoutConstraint.activate ([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
=======
    private func setupConstraints() {
        NSLayoutConstraint.activate ([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
>>>>>>> main
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
<<<<<<< HEAD
        //type safe
=======
>>>>>>> main
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
    }
}

<<<<<<< HEAD

=======
>>>>>>> main
// MARK: - Table View Data Source And Delegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
<<<<<<< HEAD
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath)
        if let homeCell = cell as? HomeTableViewCell,
           let movie = viewModel.item(at: indexPath.row) {
            homeCell.configure(with: movie, delegate: self)
=======
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath)
        if let homeCell = cell as? HomeTableViewCell {
>>>>>>> main
            
            return homeCell
        }
        
        return cell
    }
}
<<<<<<< HEAD

extension HomeViewController: HomeTableViewCellDelegate {
    func didSelectRowAt(at index: Int) {
        viewModel.didSelectRowAt(at: index, from: self)
    }
}
=======
>>>>>>> main
