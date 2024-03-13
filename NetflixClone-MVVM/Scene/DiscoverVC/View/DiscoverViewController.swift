//
//  DiscoverViewController.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 12.02.2024.
//

import UIKit
import SnapKit

class DiscoverViewController: UIViewController {
    //MARK: - Properties
    private let categoryList = MovieCategoryModel.dummyData()
    //MARK: - UIComponents
    let backroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = .discoverbackgroundIMG
        return imageView
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        return tableView
    }()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        tableView.delegate = self
        tableView.dataSource = self
    }
}
extension DiscoverViewController {
    private func setupUI() {
        view.backgroundColor = .viewBackround
        title = "Discover"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        view.addSubview(backroundImageView)
        view.sendSubviewToBack(backroundImageView)
        view.addSubview(tableView)
    }
    private func setupLayout() {
        backroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
        }
    }
}

//MARK: -
extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        let category = categoryList[indexPath.row]
        cell.configureCell(category)
        cell.backgroundColor = .clear
        cell.accessoryView = UIImageView(image: AppIcon.arrowRight.image())
        cell.tintColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * 0.15
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
