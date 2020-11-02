//
//  TopStoriesViewController.swift
//  NewYorkTimesDemo
//
//  Created by Zhaoyang Li on 10/30/20.
//

import UIKit

class TopStoriesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
        }
    }
    @IBOutlet private weak var activityIndicater: UIActivityIndicatorView!
<<<<<<< HEAD
    private var refreshControl = UIRefreshControl()
    
    lazy var viewModel = TopStoriesViewModel(delegate: self)
=======
    
    let viewModel = TopStoriesViewModel()
    var refreshControll = UIRefreshControl()
    
    private func initialUIsettings() {
        refreshControll.addTarget(self, action: #selector(fetchTopStoriesParsedData), for: .valueChanged)
        tableView.addSubview(refreshControll)
    }
>>>>>>> 27cd282d936dedb4c86db19906a895147aba00c3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUIsettings()
        fetchTopStoriesParsedData()
    }
    
<<<<<<< HEAD
    private func initialUIsettings() {
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func pullToRefresh() {
        self.fetchTopStoriesParsedData(isRefresh: true)
    }
    
    private func fetchTopStoriesParsedData(isRefresh: Bool = false) {
        viewModel.getAllResults(isRefresh: isRefresh)
    }
}

extension TopStoriesViewController: TopStoriesViewModelProtocol {
    func fetchedResults() {
        self.tableView.reloadData()
    }
    
    func didFail(message: String) {
        let alertController = UIAlertController(title: "There are something wrong", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showActivity() {
        self.activityIndicater.startAnimating()
    }
    
    func hideActivity() {
        self.activityIndicater.stopAnimating()
    }
    
    func startRefresh() {
        self.refreshControl.beginRefreshing()
    }
    
    func stopRefresh() {
        self.refreshControl.endRefreshing()
=======
    @objc private func fetchTopStoriesParsedData() {
        viewModel.parseTopStoriesDataHandler { [ weak self ] error in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                weakSelf.activityIndicater.stopAnimating()
                weakSelf.tableView.reloadData()
                weakSelf.refreshControll.endRefreshing()
            }
        }
>>>>>>> 27cd282d936dedb4c86db19906a895147aba00c3
    }
}

extension TopStoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopStoryTableViewCell.reuseIdentifier, for: indexPath) as? TopStoryTableViewCell else {
            return UITableViewCell()
        }
<<<<<<< HEAD
        let newsModel = viewModel.news(atIndex: indexPath.row)
        cell.configureCell(model: newsModel)
=======
        let story = viewModel.validStoriesDataSource[indexPath.row]
        cell.configureCell(title: story.title, abstract: story.abstract, image: story.thumbImage, postTime: story.formattedDateAndTimeString)
>>>>>>> 27cd282d936dedb4c86db19906a895147aba00c3
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyBoard = UIStoryboard(name: AppConstants.StoryBoardViews.storyBoardName, bundle: nil)
        if let detailViewController = storyBoard.instantiateViewController(identifier: AppConstants.StoryBoardViews.storyDetailViewController) as? StoryDetailViewController {
<<<<<<< HEAD
            detailViewController.news = viewModel.news(atIndex: indexPath.row)
=======
            detailViewController.chosenIndex = indexPath.row
            detailViewController.validOrignialInfo = viewModel.validStoriesDataSource[indexPath.row]
>>>>>>> 27cd282d936dedb4c86db19906a895147aba00c3
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
