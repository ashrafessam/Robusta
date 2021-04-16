//
//  RepositoriesVC.swift
//  RobustaTask
//
//  Created by Ashraf Essam on 16/04/2021.
//

import UIKit

class RepositoriesVC: UIViewController {

    var reposArray: [ReposModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchRepos()
    }
    
    private func fetchRepos(){
        APIManager.shared.fetchReposJSON { (res) in
            switch res {
            case .success(let repos):
                DispatchQueue.main.async {
                    self.reposArray = repos
                    print(self.reposArray?.count ?? 0)
                }
            case .failure(let error):
                print("Failed to fetch repos", error)
            }
        }
    }
}
