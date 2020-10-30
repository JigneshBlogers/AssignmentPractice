
import UIKit

class HomeFeedsViewController: UIViewController {
    let cellIdentifier = "canadaCell"
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    var refreshControl: UIRefreshControl?
    
    var viewModel = AboutCanadaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.viewModel.title
        setUPTableView()
        setConstrains()
        addRefreshControl()
        getData()
    }
    
    fileprivate func addRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .red
        refreshControl?.attributedTitle = NSAttributedString(string: Constants.CommonText.pullToRefresh)
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc
    func refreshData() {
        getData()
    }
    
    func getData() {
        view.activityIndicatory()
        viewModel.getData(url: Constants.APIEndPoint.baseURL) { [weak self] (result) in
            self?.view.activityIndicatory(animate: false)
            self?.tableView.refreshControl?.endRefreshing()
            switch result {
            case .success(_):
                self?.title = self?.viewModel.title
                self?.tableView.reloadData()
                
            case .failure(let error):
                print(error.errorDescription ?? "")
            }
        }
    }
    
    fileprivate func setConstrains() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    fileprivate func setUPTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(HomeContentTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

extension HomeFeedsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.noOfRows
    }
    
    fileprivate func downloadImage(_ url: URL?, _ indexPath: IndexPath, _ tableView: UITableView) {
        ImageDownloadManager.shread.downloadImage(url: url, indexPath: indexPath) { (image, _, indexPath1, _) in
            if image != nil {
                DispatchQueue.main.async {
                    let cell1 = tableView.cellForRow(at: indexPath1!) as? HomeContentTableViewCell
                    cell1?.profileImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    let cell1 = tableView.cellForRow(at: indexPath1!) as? HomeContentTableViewCell
                    cell1?.profileImageView.image = #imageLiteral(resourceName: "placeholder")
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HomeContentTableViewCell else {return UITableViewCell()}
        cell.titleLabel.text = viewModel.getTitle(index: indexPath.row)
        cell.descriptionLabel.text = viewModel.getDescription(index: indexPath.row)
        let url = URL(string: viewModel.getImageURLString(index: indexPath.row) ?? "")
        downloadImage(url, indexPath, tableView)
        return cell
    }
}
