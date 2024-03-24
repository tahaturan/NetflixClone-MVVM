//
//  DownloadViewController.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 12.02.2024.
//

import UIKit
import RealmSwift

class DownloadViewController: UIViewController {
    //MARK: - Properties
    private var movieList: [RealmMovieObject] = []
    var downloadViewModel: DownloadViewModel?
    //MARK: - UIComponents
    private lazy var backroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .discoverbackgroundIMG
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let downlodTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UpComingTableViewCell.self, forCellReuseIdentifier: UpComingTableViewCell.identifier)
        return tableView
    }()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        downloadViewModel?.delegate = self
        downloadViewModel?.getMovieToRealm()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downloadViewModel?.getMovieToRealm()
    }
}
//MARK: - Helper
extension DownloadViewController {
    private func setupUI() {
        view.backgroundColor = .viewBackround
        title = "Download"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        view.addSubview(backroundImageView)
        view.sendSubviewToBack(backroundImageView)
        view.addSubview(downlodTableView)
        downlodTableView.delegate = self
        downlodTableView.dataSource = self
    }
    private func setupLayout() {
        backroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        downlodTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
    }
}
//MARK: - DownloadViewModelDelegate
extension DownloadViewController: DownloadViewModelDelegate {
    func handleOutput(_ output: DownloadViewModelOutput) {
        switch output {
        case .movieList(let results):
            self.movieList = results
            DispatchQueue.main.async {
                self.downlodTableView.reloadData()
            }
        }
    }
    
    
}
//MARK: - UITableView  Delegate/DataSource
extension DownloadViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpComingTableViewCell.identifier, for: indexPath) as? UpComingTableViewCell else { return UITableViewCell() }
         let movie = movieList[indexPath.row]
        
        cell.configureCell(realmMovie: movie)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * 0.2
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {[weak self] action, view, completion in
            guard let strongSelf = self else {
                completion(false)
                return
            }
            let movie = strongSelf.movieList[indexPath.row]
            strongSelf.downloadViewModel?.deleteMovieToRealm(movie)
            strongSelf.movieList.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .middle)
            
            completion(true)
        }
        
        let configiration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return configiration
    }
}
