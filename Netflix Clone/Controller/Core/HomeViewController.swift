//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Moamen on 31/03/2024.
//

import UIKit


enum Sections : Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}


class HomeViewController: UIViewController  {
    private var randomTrendingMovie: Title?
    private var headerView: HeroHeaderView?
    
    let sectionTitles: [String] = ["Trending Movies", "Trending Tv", "Popular", "Upcoming Movies", "Top rated"]
    
    private let homeTable: UITableView = {
        let table = UITableView(frame: .zero , style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifer)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(homeTable)
        
        headerHandler()
        homeTable.delegate = self
        homeTable.dataSource = self
        headerView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width , height: 500))
        homeTable.tableHeaderView = headerView
        configureHeroHeaderView()
    }
    private func configureHeroHeaderView() {
        
        ApiCaller.shared.getTrending { [weak self] result in
            switch result {
            case .success(let titles):
                let selectedTitle = titles.randomElement()
                
                self?.randomTrendingMovie = selectedTitle
                self?.headerView?.configure(with: titleViewModel(titleName: selectedTitle?.original_title ?? "", posterURL: selectedTitle?.poster_path ?? ""))
                
            case .failure(let erorr):
                print(erorr.localizedDescription)
            }
        }
        
        
        
    }
    override func viewDidLayoutSubviews() {
        homeTable.frame = view.bounds
    }
    private func headerHandler(){
        var image = UIImage(named: "netflix")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done , target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self , action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self , action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    
    
    private func configureNavbar() {
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    
}

extension HomeViewController: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifer, for: indexPath)
                as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        CollectionViewTableViewCell.delegate = self
        switch indexPath.section{
        case Sections.TrendingMovies.rawValue:
            ApiCaller.shared.getTrending { results in
                switch results {
                case .success(let title):
                    cell.Configurate(with: title)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            
            }
        case Sections.TrendingTv.rawValue:
            ApiCaller.shared.getTrendingTvs { results in
                switch results {
                case .success(let title):
                    cell.Configurate(with: title)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            
            }
        case Sections.Popular.rawValue:
            ApiCaller.shared.getPopular { results in
                switch results {
                case .success(let title):
                    cell.Configurate(with: title)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            
            }
        case Sections.Upcoming.rawValue:
            ApiCaller.shared.getUpcoming { results in
                switch results {
                case .success(let title):
                    cell.Configurate(with: title)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue:
            ApiCaller.shared.getTopRated{ results in
                switch results {
                case .success(let title):
                    cell.Configurate(with: title)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            
            }
        default:
            return UITableViewCell()
        }
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18 , weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20 , y: header.bounds.origin.y , width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeLetter()

    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController : CollectionViewTableViewCellDelegate {
    func CollectionViewTableViewCellDidTap(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async {
            let vc = TitlePreviewViewController()
            vc.configurate(with: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}



