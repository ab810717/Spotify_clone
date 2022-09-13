//
//  LibraryPlaylistViewController.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/24.
//

import UIKit

class LibraryPlaylistViewController: UIViewController {
    
    // MARK: - Properties
    var selectionHandler: ((Playlist) -> Void)?
    let viewModel = LibraryPlaylistViewViewModel()
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
        viewModel.delegate = self
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(noPlaylistView)
        view.addSubview(tableView)
        setUpNoPlaylistView()
        fetchData()
        
        if selectionHandler != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapClose))
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistView.setDimensions(height: 150, width: 150)
        noPlaylistView.center(inView: view)
        tableView.frame = view.bounds
    }
    
    
    // MARK: - Helper functions
    
    func fetchData() {
        viewModel.fetchData()
    }
    
    private func setUpNoPlaylistView() {
        noPlaylistView.delegate = self
        noPlaylistView.configure(with: ActionLabelViewModel(
            text: "You don't have any playlist yet.",
            actionTitle: "Create"))
        
    }
    
    func showCreatePlaylistAlert() {
        let alert = UIAlertController(title: "New Playlist", message: "Enter Playlist name.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Playlist.."
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                return
            }
            self?.viewModel.createPlaylist(with: text)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
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
        return viewModel.playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath)
                as? SearchResultSubtitleTableViewCell else {
            return UITableViewCell()
        }
        let playlist = viewModel.playlists[indexPath.row]
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(
            title: playlist.name,
            subtitle: playlist.owner.displayName,
            imageURL: URL(string: playlist.images.first?.url ?? "")))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let playlist = viewModel.playlists[indexPath.row]
        guard selectionHandler == nil else {
            selectionHandler?(playlist)
            dismiss(animated: true,completion: nil)
            return
        }
        let vc = PlaylistViewController(playlist: playlist)
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.isOwner = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - LibraryPlaylistViewViewModelOutput
extension LibraryPlaylistViewController:LibraryPlaylistViewViewModelOutput {
    func updateUI() {
        print("DEBUG: update UI is invoked() " )
        if viewModel.playlists.isEmpty {
            // show label
            print("show label")
            noPlaylistView.isHidden = false
        } else {
            print("show table")
            tableView.reloadData()
            tableView.isHidden = false
            // show table
        }
        
    }
    
    
}

