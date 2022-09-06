//
//  ProfileViewController.swift
//  Spotify
//
//  Created by Andy Hao on 2022/7/19.
//

import UIKit
import SDWebImage
class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableview: UITableView = {
       let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var models = [String]()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemBackground
        fetchProfile()
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
    // MARK: - Private
    
    private func fetchProfile() {
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.updateUI(with: model)
                    print("DEBUG: Get result: \(result)")
                case .failure(let error):
                    self.failedToGetProfile()
                    print("DEBUG: Get an error: \(error.localizedDescription)")
                }
            }
            
        }
    }
    
    private func updateUI(with model: UserProfile) {
        tableview.isHidden = false
        // Cofigure tabel models
        models.append("Full Name: \(model.displayName)")
        models.append("Email Address: \(model.email)")
        models.append("User ID: \(model.id)")
        models.append("plan: \(model.product)")
        createTableHeader(with: model.images.first?.url)
        tableview.reloadData()
    }
    
    private func failedToGetProfile() {
        let label = UILabel(frame: .zero)
        label.text = "Failed to load profile."
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
    }
    
    private func createTableHeader(with string: String? ) {
        guard let urlString = string , let url = URL(string: urlString) else {
            print("DEBUG: Invalid url")
            return }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width / 1.5))
        let imageSize: CGFloat = headerView.height / 2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        tableview.tableHeaderView = headerView
        imageView.center = headerView.center
        imageView.contentMode = .scaleToFill
        imageView.sd_setImage(with: url, completed: nil)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize / 2
        headerView.addSubview(imageView)
        
        
    }
    
  

}

// MARK: Extention UITableViewDelegate & UITableViewDataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    
}
