//
//  PlaylistViewController.swift
//  Spotify
//
//  Created by Andy Hao on 2022/7/19.
//

import UIKit

class PlaylistViewController: UIViewController {
    // MARK: - Properties
    private let playlist: Playlist
    public var isOwner = false 
    let viewModel:PlaylistViewViewModel
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: {_, _ -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 1.0, leading: 2.0, bottom: 1.0, trailing: 2.0)
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(70)),
                subitem: item,
                count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)]
            return section
        })
    )
    
    // MARK: - LifeCycle
    
    init(playlist:Playlist) {
        self.playlist = playlist
        self.viewModel = PlaylistViewViewModel(playlist: playlist)
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureGesture()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    //MARK: - Private fucntions
    private func configureUI () {
        view.backgroundColor = .systemBackground
        title = playlist.name
        view.addSubview(collectionView)
        collectionView.register(RecommendedTrackCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PlaylistHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
    }
    
    private func configureGesture() {
        let gestrue = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
        collectionView.addGestureRecognizer(gestrue)
    }
    
    private func fetchData() {
        viewModel.fetchData()
    }
    
    // MARK: - Actions
    @objc func didTapShare() {
        print("DId tap share button!, url: \(playlist.externalUrls)")
        guard let url = URL(string: playlist.externalUrls["spotify"] ?? "" ) else { return }
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else {
            return
        }
        
        let touchPoint = gesture.location(in: collectionView)
        guard let indexpath = collectionView.indexPathForItem(at: touchPoint) else {
            return
        }
        
        let trackDelete = viewModel.tracks[indexpath.row]
        print("DEBUG: check delete track name: \(trackDelete.name)")
        
        let actionSheet = UIAlertController(title: trackDelete.name, message: "Would you like to remove this from playlist? ", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.removeTrackFromplaylist(track: trackDelete, playlist: self.viewModel.playlist, indexpath: indexpath.row)
            
        }))
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension PlaylistViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.recommendedTrackCellViewModels.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedTrackCollectionViewCell.identifier, for: indexPath) as? RecommendedTrackCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .red
        cell.configure(with: viewModel.recommendedTrackCellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier,
            for: indexPath) as? PlaylistHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let headerViewModel = PlaylistHeaderViewViewModel(name: playlist.name,
                                                          ownerName: playlist.owner.displayName,
                                                          description: playlist.description,
                                                          artworkURL: URL(string: playlist.images.first?.url ?? ""))
        header.configure(with: headerViewModel)
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // Play song
        let index = indexPath.row
        let track = viewModel.tracks[index]
        PlaybackPresenter.shared.startPlayback(from: self, track: track)
    }
    
    
}


// MARK: - PlaylistHeaderCollectionReusableViewDelegate
extension PlaylistViewController:PlaylistHeaderCollectionReusableViewDelegate {
    func playListHeaderDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView) {
        PlaybackPresenter.shared.startPlayback(from: self, tracks: viewModel.tracks)
    }
}



extension PlaylistViewController: PlaylistViewViewModelOutput {
    func updateUIAfterRemoveTrackFromPlaylist(indexPath: Int) {
        DispatchQueue.main.async {
            self.viewModel.tracks.remove(at: indexPath)
            self.viewModel.recommendedTrackCellViewModels.remove(at: indexPath)
            self.collectionView.reloadData()
        }
    }
    
    func updateUI() {
        collectionView.reloadData()
    }
    
}
