//
//  LibraryAlbumsViewController.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/24.
//

import UIKit

class LibraryAlbumsViewController: UIViewController {
    // MARK: - Properties
    let viewModel = LibraryAlbumsViewViewModel()
    private let noAlbumView = ActionLabelView()
    private let tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    private var observer:NSObjectProtocol?
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(noAlbumView)
        view.addSubview(tableView)
        setUpNoAlbumView()
        fetchData()
        observer = NotificationCenter.default.addObserver(forName: .albumSaveNotification, object: nil, queue: .main, using: { [weak self] _ in
            self?.fetchData()
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noAlbumView.setDimensions(height: view.height / 3, width: view.height / 3)
        noAlbumView.center(inView: view)
        tableView.frame = view.bounds
    }
    
    
    // MARK: - Helper functions
    
    func fetchData() {
        viewModel.fetchData()
    }
    
    private func setUpNoAlbumView() {
        noAlbumView.delegate = self
        noAlbumView.configure(with: ActionLabelViewModel(
            text: "You have not have saved any Album yet.",
            actionTitle: "Browse"))
    }
    
    
}


// MARK: - ActionLabelViewDelegate
extension LibraryAlbumsViewController: ActionLabelViewDelegate {
    func ActionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        tabBarController?.selectedIndex = 0
    }
}

extension LibraryAlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultSubtitleTableViewCell.identifier,
            for: indexPath) as? SearchResultSubtitleTableViewCell else {
            return UITableViewCell()
        }
        let album = viewModel.albums[indexPath.row]
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(title: album.name, subtitle: album.artists.first?.name ?? "-", imageURL: URL(string: album.images.first?.url ?? "")))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HapticsManager.shared.vibrateForSelection()
        tableView.deselectRow(at: indexPath, animated: true)
        let album = viewModel.albums[indexPath.row]
        let vc = AlbumViewController(album: album)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - LibraryAlbumsViewViewModelOutput
//  
extension LibraryAlbumsViewController:LibraryAlbumsViewViewModelOutput {
    func updateUI() {
        if self.viewModel.albums.isEmpty {
            self.noAlbumView.isHidden = false
            
        } else {
            self.noAlbumView.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    
}
