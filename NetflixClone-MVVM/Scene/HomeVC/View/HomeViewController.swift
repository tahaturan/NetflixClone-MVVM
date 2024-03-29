//
//  HomeViewController.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 12.02.2024.
//

import SnapKit
import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    // MARK: - Properties
    private var tableViewTopConstraint: Constraint?
    private let sectionTitles: [String] = ["Trending Movies","Upcoming Movies", "Top Rated","Trending TV"]
    var homeViewModel: HomeViewModel?
    private var popularMovieList: [MovieResult] = []
    private var trendingTvList: [MovieResult] = []
    private var trendingMoviesList: [MovieResult] = []
    private var upcomingMoviesList: [MovieResult] = []
    private var topRatedList: [MovieResult] = []
    private var isNotificationPermisson: Bool = false // bildirim onayi
    // MARK: - UICompenents

    private lazy var backroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .homebackgroundIMG
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.font = AppFont.generalTitle.font()
        label.textColor = .white
        return label
    }()

    private let searchButton: AppSearchButton = AppSearchButton()
    private var tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    private var headerCollectionView: UICollectionView!
    private var indicator: CustomActivityIndicator = CustomActivityIndicator()
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        homeViewModel?.delegate = self
        homeViewModel?.loadData()
        searchButton.delegate = self
        notificationPermisson()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - Helper

extension HomeViewController {
    private func setupUI() {
        view.backgroundColor = .viewBackround
        navigationController?.navigationBar.isHidden = true
        navigationItem.backButtonTitle = ""
        view.addSubview(backroundImageView)
        view.sendSubviewToBack(backroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(searchButton)
        setupHeaderCollectionView()
        setupTableView()
    }

    private func setupLayout() {
        backroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(10)
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(10)
            make.width.height.equalTo(AppSize.searchButton.size().width)
        }
        tableView.snp.makeConstraints { make in
            tableViewTopConstraint = make.top.equalTo(titleLabel.snp.bottom).offset(20).constraint
            make.leading.equalToSuperview().inset(10)
            make.trailing.bottom.equalToSuperview()
        }
    }
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MovieCollectionViewTableViewCell.self, forCellReuseIdentifier: MovieCollectionViewTableViewCell.identifier)
        tableView.register(HomeHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HomeHeaderFooterView.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        headerCollectionView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height * 0.4)
        tableView.tableHeaderView = headerCollectionView
    }
    private func setupHeaderCollectionView() {
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: view.bounds.width * 0.85, height: view.bounds.width * 0.75)
           headerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           headerCollectionView.delegate = self
           headerCollectionView.dataSource = self
        headerCollectionView.register(HomeHeaderCollectionViewCell.self, forCellWithReuseIdentifier: HomeHeaderCollectionViewCell.identifier)
           headerCollectionView.backgroundColor = .clear
        headerCollectionView.showsHorizontalScrollIndicator = false
        
    }
}

// MARK: - UITableView Delegate/DataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCollectionViewTableViewCell.identifier, for: indexPath) as? MovieCollectionViewTableViewCell else {
            return UITableViewCell()
        }
        switch indexPath.section {
        case HomeSectionTableView.trendingMovie.rawValue:
            cell.configureCell(trendingMoviesList)
        case HomeSectionTableView.upComing.rawValue:
            cell.configureCell(upcomingMoviesList)
        case HomeSectionTableView.topRated.rawValue:
            cell.configureCell(topRatedList)
        case HomeSectionTableView.trendingTV.rawValue:
            cell.configureCell(trendingTvList)
        default:
            cell.configureCell(popularMovieList)
        }
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * 0.25
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.bounds.height * 0.05
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let hideThreshold: CGFloat = 100
        if scrollView.contentOffset.y > hideThreshold {
            UIView.animate(withDuration: 1) {
                self.titleLabel.alpha = 0
                self.searchButton.alpha = 0
                self.tableViewTopConstraint?.update(offset: -20)
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 1) {
                self.titleLabel.alpha = 1
                self.searchButton.alpha = 1
                self.tableViewTopConstraint?.update(offset: 20)
                self.view.layoutIfNeeded()
            }
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeHeaderFooterView.identifier) as? HomeHeaderFooterView else { return nil }
        
        header.titleLabel.text = sectionTitles[section]
        
        return header
    }
}
//MARK: - -Header- UICollectionView Delegate/DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHeaderCollectionViewCell.identifier, for: indexPath) as? HomeHeaderCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = popularMovieList[indexPath.row]
        cell.configureCell(movie: movie)
        return cell
    }
    
}
//MARK: - MovieCollectionViewTableViewCellDelagate
extension HomeViewController: MovieCollectionViewTableViewCellDelagate {
    func didSelectMovie(_ movie: MovieResult) {
        let detailVC = DetailViewBuilder.makeDetailViewController(movieID: movie.id ?? 178)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func downloadActinClicked(_ movie: MovieResult) {
        homeViewModel?.saveMovieRealm(with: movie)
        if isNotificationPermisson {
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "Dowload is Succesfull"
            notificationContent.body = "\(movie.title ?? "") is Downloaded"
            notificationContent.badge = 1
            notificationContent.sound = .default
            
            let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
            let notificationRequest = UNNotificationRequest(identifier: "dowload", content: notificationContent, trigger: notificationTrigger)
            UNUserNotificationCenter.current().add(notificationRequest)
        }
    }
    func sharedActionCliced(url: URL) {
        let shareSheedVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(shareSheedVC, animated: true)
    }
}
//MARK: - HomeViewModel
extension HomeViewController: HomeViewModelDelegate{
    func handleOutput(_ output: HomeViewModelOutput) {
        switch output {
        case .popularMovies(let array):
            self.popularMovieList = array
            DispatchQueue.main.async {
                self.headerCollectionView.reloadData()
            }
        case .upComingMovies(let array):
            self.upcomingMoviesList = array
        case .topRatedMovies(let array):
            self.topRatedList = array
        case .trendingTv(let array):
            self.trendingTvList = array
        case .trendingMovie(let array):
            self.trendingMoviesList = array
        case .setLoading(let isLoading):
            DispatchQueue.main.async {
                isLoading ? self.indicator.show(on: self) : self.indicator.hide()
            }
        case .error(let error):
            showAlert(title: "Error", message: error.localizedDescription)
        }
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
//MARK: - AppSearchButtonDelegate
extension HomeViewController: AppSearchButtonDelegate {
    func searchButtonClicked() {
        let searchVC = SearchViewBuilder.makeSearchViewController()
        searchVC.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(searchVC, animated: true)
    }
}
//MARK: - LocalNotification and UNUserNotificationCenterDelegate
extension HomeViewController: UNUserNotificationCenterDelegate {
    //Bildirim onayi
    private func notificationPermisson() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
            self?.isNotificationPermisson = granted
        }
    }
    //Uygulama acik iken
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    // bildirim secildiginde
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        do {
            try await UNUserNotificationCenter.current().setBadgeCount(0)
        } catch  {
            showAlert(title: "Error", message: error.localizedDescription)
        }
        tabBarController?.selectedIndex = 3
    }
}
