//
//  PostListTableViewController.swift
//  Continuum
//
//  Created by Jaymond Richardson on 5/11/21.
//

import UIKit

class PostListTableViewController: UITableViewController {
    //MARK: - Outlets
    
    @IBOutlet weak var postSearchBar: UISearchBar!
    
    
    //MARK: - Properties
    var resultsArray: [SearchableRecord] = []
    var isSearching = false
    var dataSource: [SearchableRecord] {
        return isSearching ? resultsArray : PostController.shared.posts
    }
    
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postSearchBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resultsArray = PostController.shared.posts
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else {return UITableViewCell()}
        
        let post = dataSource[indexPath.row] as? Post
        
        cell.post = post
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC",
           let indexPath = tableView.indexPathForSelectedRow,
           let destinationVC = segue.destination as? PostDetailTableViewController {
            let post = dataSource[indexPath.row] as? Post //replaced shared instance with data source through properties
            destinationVC.post = post
        }
    }
    
}//End of class

//MARK: - SearchBar Delegate Extension

extension PostListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty{
            let filteredArray = PostController.shared.posts.filter{ $0.matches(searchTerm: searchText.lowercased())}
            resultsArray = filteredArray
            
        } else {
            resultsArray = PostController.shared.posts
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resultsArray = PostController.shared.posts
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearching = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)  {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
}
