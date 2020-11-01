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
    
    let viewModel = TopStoriesViewModel()
    var refreshControll = UIRefreshControl()
    
    private func initialUIsettings() {
        refreshControll.addTarget(self, action: #selector(fetchTopStoriesParsedData), for: .valueChanged)
        tableView.addSubview(refreshControll)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUIsettings()
        fetchTopStoriesParsedData()
    }
    
    @objc private func fetchTopStoriesParsedData() {
        viewModel.parseTopStoriesDataHandler { [ weak self ] error in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                weakSelf.activityIndicater.stopAnimating()
                weakSelf.tableView.reloadData()
                weakSelf.refreshControll.endRefreshing()
            }
        }
    }
}

extension TopStoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.validStoriesDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopStoryTableViewCell.reuseIdentifier, for: indexPath) as? TopStoryTableViewCell else {
            return UITableViewCell()
        }
        let story = viewModel.validStoriesDataSource[indexPath.row]
        cell.configureCell(title: story.title, abstract: story.abstract, image: story.thumbImage, postTime: story.formattedDateAndTimeString)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyBoard = UIStoryboard(name: AppConstants.StoryBoardViews.storyBoardName, bundle: nil)
        if let detailViewController = storyBoard.instantiateViewController(identifier: AppConstants.StoryBoardViews.storyDetailViewController) as? StoryDetailViewController {
            detailViewController.chosenIndex = indexPath.row
            detailViewController.validOrignialInfo = viewModel.validStoriesDataSource[indexPath.row]
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
