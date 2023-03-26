import UIKit

class ViewController: UIViewController {
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view = tableView
        configureNavigation()
    }
    
    private lazy var searchContoller: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "검색어 입력"
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private func configureNavigation() {
        self.navigationItem.title = "검색"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchContoller
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}



extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        print("updateSearchResults: \(searchText)")
    }
}

extension ViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        print("didDismissSearchController")
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        print("searchBarSearchButtonClicked!: \(searchText)")
    }
}
    

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
//        return self.viewModel.wordsCount()
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "Title"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt: ", indexPath.row)
    }
}

