//
//  RepositoriesVC.swift
//  RobustaTask
//
//  Created by Ashraf Essam on 16/04/2021.
//

import UIKit

class RepositoriesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var reposArray: [ReposModel]?
    var filterArray: [ReposModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NavigationTitle(title: Constants.Repositories)
        RegisterNib()
        fetchRepos()
    }
    private func NavigationTitle(){
        navigationItem.title = Constants.Repositories
    }
    
    private func RegisterNib(){
        tableView.registerCellNib(cellClass: RepositoriesCell.self)
    }
    
    private func fetchRepos(){
        APIManager.shared.fetchReposJSON { (res) in
            switch res {
            case .success(let repos):
                DispatchQueue.main.async {
                    self.reposArray = repos
                    self.filterArray = repos
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch repos", error)
            }
        }
    }
}

extension RepositoriesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filterArray = reposArray;
            tableView.reloadData()
            return
        }
        filterArray = reposArray?.filter({ (repo) -> Bool in
            return repo.name.contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}

extension RepositoriesVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as RepositoriesCell
        let item = filterArray?[indexPath.row]
        cell.repoAvatar.loadImageUsingUrlString(urlString: item?.owner.avatarURL ?? "")
        cell.configureText(repoName: "Repo Name: \(item?.name ?? "")", ownerName: "Owner Name: \(item?.owner.login ?? "")")
        return cell
    }
}

extension RepositoriesVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = filterArray?[indexPath.row]
        let vc = ControllerProvider.viewContoller(className: RepositoryDetailsVC.self, storyboard: .MainStoryboard, presentationStyle: .none)
        vc.repoUrl = item?.owner.url
        vc.repoName = item?.name
        navigationController?.pushViewController(vc, animated: true)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
