//
//  LibraryPlaylistViewController.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/24.
//

import UIKit

class LibraryPlaylistViewController: UIViewController {
    
    // MARK: - Properties
    var playlists = [Playlist]()
    private let noPlaylistView = ActionLabelView()
    private let tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(noPlaylistView)
        view.addSubview(tableView)
        setUpNoPlaylistView()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistView.setDimensions(height: 150, width: 150)
        noPlaylistView.center(inView: view)
        tableView.frame = view.bounds
    }
    
    
    // MARK: - Helper functions
    
    func fetchData() {
        APICaller.shared.getCurrentUserPlaylists { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    print("Get playlists: \(playlists)")
                    self?.playlists = playlists
                    self?.updateUI()
                    break
                case .failure(let error):
                    print("Get an error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func setUpNoPlaylistView() {
        noPlaylistView.delegate = self
        noPlaylistView.configure(with: ActionLabelViewModel(
            text: "You don't have any playlist yet.",
            actionTitle: "Create"))
        
    }
    
    func updateUI() {
        print("DEBUG: update UI is invoked() " )
        if playlists.isEmpty {
            // show label
            print("show label")
            noPlaylistView.isHidden = false
        } else {
            print("show table")
//            noPlaylistView.isHidden = false
            tableView.reloadData()
            tableView.isHidden = false
            // show table
        }
        
    }
    
    func showCreatePlaylistAlert() {
        let alert = UIAlertController(title: "New Playlist", message: "Enter Playlist name.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Playlist.."
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                return
            }
            APICaller.shared.createPlaylist(with: text) { success in
                if success {
                    self.fetchData()
                    print("Create playlist successfully!")
                } else {
                    print("Failed to create playlist")
                }
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - ActionLabelViewDelegate
extension LibraryPlaylistViewController: ActionLabelViewDelegate {
    func ActionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        // show creation UI
       showCreatePlaylistAlert()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension LibraryPlaylistViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath)
                as? SearchResultSubtitleTableViewCell else {
            return UITableViewCell()
        }
        let playlist = playlists[indexPath.row]
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(
            title: playlist.name,
            subtitle: playlist.owner.displayName,
            imageURL: URL(string: playlist.images.first?.url ?? "")))
        return cell
        
    }
}

