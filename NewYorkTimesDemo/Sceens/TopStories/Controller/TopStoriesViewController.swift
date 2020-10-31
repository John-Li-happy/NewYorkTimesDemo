//
//  TopStoriesViewController.swift
//  NewYorkTimesDemo
//
//  Created by Zhaoyang Li on 10/30/20.
//

import UIKit

class TopStoriesViewController: UIViewController {
    let viewModel = ViewModel()
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = 120
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTopStoriesParsedData()
    }
    
    private func fetchTopStoriesParsedData() {
        viewModel.parseTopStoriesDataHandler { error in
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
        cell.configureCell(title: story.title, abstract: story.abstract, image: story.thumbImage, postTime: story.time)
        return UITableViewCell()
    }
    
    
}
