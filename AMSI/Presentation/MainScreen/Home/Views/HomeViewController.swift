//
//  HomeViewController.swift
//  AMSI
//
//  Created by Anton Petrov on 16.10.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - UI Elements

    private let headerView = HomeViewHeader()
    private let jobsTableView = UITableView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Assets.Colors.Shared.screenBackground.color
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar()
    }

    // MARK: - Setup

    private func setupTableView() {
        view.addSubview(jobsTableView)
        jobsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        jobsTableView.register(HomeJobCell.self,
                               forCellReuseIdentifier: HomeJobCell.reuseIdentifier)
        jobsTableView.contentInset = .init(top: 0, left: 0, bottom: 80, right: 0)
        jobsTableView.dataSource = self
        jobsTableView.tableHeaderView = headerView
        jobsTableView.tableHeaderView?.frame.size = CGSize(width: 0, height: 450)
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MockJobs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeJobCell.reuseIdentifier,
                                                       for: indexPath) as? HomeJobCell else { return UITableViewCell() }
        cell.configure(withJob: MockJobs[indexPath.row])
        return cell
    }
}
