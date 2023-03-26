import UIKit

class ViewController: UIViewController {
    private let cellId = "cellId"
    private let recentSearchRepository = RecentSearchRepository(words: ["Apple", "Appear", "Orange", "Banana", "Game"])
    
    // 화면에 보여줄 입력한 글자와 일치하는 검색어 목록
    private var matchedWords: [String] = []
    
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
    
    private func updateWords(inputText: String) {
        // 1. 글자 입력이 없으면, 전체 최근 검색어들을 보여준다
        if inputText.isEmpty {
            self.matchedWords = recentSearchRepository.all()
            self.tableView.reloadData()
            return
        }
        
        // 2. 글자 입력이 있으면 최근 검색어에서 일치하는 단어만 보여준다
        let matchPrefixWords = recentSearchRepository.prefixWords(with: inputText)
        self.matchedWords = matchPrefixWords
        self.tableView.reloadData()
    }
}



extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        updateWords(inputText: searchText)
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
        return self.matchedWords.count
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = self.matchedWords[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt: ", indexPath.row)
    }
}
