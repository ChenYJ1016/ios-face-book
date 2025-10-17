//
//  ViewController.swift
//  ios-face-book
//
//  Created by James Chen on 16/10/25.
//

import UIKit

class MainViewController: UIViewController {
    
    let tableView = UITableView()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    var users : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "🙂📘"
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground

        // Do any additional setup after loading the view.
        setupNavigationBar()
        setupActivityIndicator()
        setupTableView()
        fetchUserData()
    }
    
    // MARK: Helper methods
    private func setupActivityIndicator(){
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    private func setupNavigationBar(){
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .blue
        
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 30)]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 30, weight: .semibold)]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    private func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
    }
    
    private func fetchUserDetails() async throws -> [User]{
        let url = URL(string: "https://dummyjson.com/users?limit=10")
        let (data, _) = try await URLSession.shared.data(from: url!)
        
        let decoder = JSONDecoder()
        let userList = try decoder.decode(UserList.self, from: data)
        
        return userList.users
    }
    
    private func fetchUserImage() async throws -> UIImage{
        let url = URL(string: "https://100k-faces.vercel.app/api/random-image")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return UIImage(data: data)!
        
    }
    
    
    private func fetchUserData(){
        activityIndicator.startAnimating()
        
        Task {
            do {
                var userDetails = try await fetchUserDetails()
                
                try await withThrowingTaskGroup(of: (Int, UIImage).self ){ group in
                    for (index, _) in userDetails.enumerated(){
                        group.addTask{
                            let image = try await self.fetchUserImage()
                            return (index, image)
                        }
                    }
                    
                    for try await (index, image) in group{
                        userDetails[index].profileImage = image
                    }
                }
                
                self.users = userDetails
                self.tableView.reloadData()
            }catch{
                print("Error! \(error)")
            }
            
            activityIndicator.stopAnimating()
        }
    }
}

extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.identifier, for: indexPath) as? PersonTableViewCell else {
                return UITableViewCell()
        }
                
        let user = users[indexPath.row]
        cell.configure(with: user)
        cell.accessoryType = .disclosureIndicator
        return cell
                
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tappedUser = users[indexPath.row]
        let vc = UserDetailViewController(user: tappedUser)
        navigationController?.pushViewController(vc, animated: true)
    }
}
