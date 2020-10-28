
import UIKit

class HomeFeedsViewController: UIViewController {
    
    // MARK: - Properties

    var tableViewFeeds = UITableView() {
        didSet {
            // Configure tablew View
            tableViewFeeds.dataSource = self
            tableViewFeeds.register(HomeContentTableViewCell.self, forCellReuseIdentifier: HomeContentTableViewCell.reuseIdentifire)
        }
    }
    
    var safeArea: UILayoutGuide!

    // MARK: - UIView LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupTableView()
    }

    // MARK: - User Define Function Calls
    func setupTableView() {
      self.view.addSubview(tableViewFeeds)
      tableViewFeeds.translatesAutoresizingMaskIntoConstraints = false
      tableViewFeeds.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
      tableViewFeeds.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
      tableViewFeeds.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      tableViewFeeds.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension HomeFeedsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeContentTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath) as! HomeContentTableViewCell
        return cell
    }
}
