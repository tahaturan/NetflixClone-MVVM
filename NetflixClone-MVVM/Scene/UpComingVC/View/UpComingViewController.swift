//
//  UpComingViewController.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 12.02.2024.
//

import UIKit
import SnapKit

class UpComingViewController: UIViewController {
    //MARK: - Properties
    var upComingViewModel: UpComingViewModel?
    private var upComingMovies: [MovieResult] = []
    //MARK: - UIComponents
    private lazy var backroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .discoverbackgroundIMG
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let upComingTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(UpComingTableViewCell.self, forCellReuseIdentifier: UpComingTableViewCell.identifier)
        return tableView
    }()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        upComingViewModel?.delagate = self
        upComingViewModel?.getUpcomingMovies()
    }
}
//MARK: - Helper
extension UpComingViewController {
    private func setupUI() {
        view.backgroundColor = .viewBackround
        title = "Coming Soon"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        view.addSubview(backroundImageView)
        view.sendSubviewToBack(backroundImageView)
        view.addSubview(upComingTableView)
        
        upComingTableView.delegate = self
        upComingTableView.dataSource = self
    }
    
    private func setupLayout() {
        backroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        upComingTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//MARK: - UITableView Delegate/DataSource
extension UpComingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upComingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpComingTableViewCell.identifier, for: indexPath) as? UpComingTableViewCell else { return UITableViewCell() }
        let movie = upComingMovies[indexPath.row]
        cell.configureCell(movie)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * 0.2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UpComingViewModel Output
extension UpComingViewController: UpComingViewModelDelegate {
    func handleOutput(_ output: UpComingViewModelOutput) {
        //TODO: alert ile error ve loding ile de activity indicator yapilacak
        switch output {
        case .upComingMovies(let array):
            self.upComingMovies = array
        case .error(let error):
            print(error)
        case .setLoading(let bool):
            print(bool)
        }
        
        DispatchQueue.main.async {
            self.upComingTableView.reloadData()
        }
    }
    
    
}
