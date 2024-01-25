//
//  ViewController.swift
//  StonksApp
//
//  Created by Нурбол Мухаметжан on 23.01.2024.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupViews()
        setupLayouts()
        setupTableView()
    }
    
    
    func setupLayouts(){
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 48) // Adjust the height as needed
        ])
            
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            menuBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            menuBar.heightAnchor.constraint(equalToConstant: 32),
            menuBar.widthAnchor.constraint(equalToConstant: 207)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: menuBar.bottomAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
    }
    
    func setupViews(){
        view.addSubview(searchBar)
        searchBar.delegate = self
        view.addSubview(menuBar)
        view.addSubview(tableView)
    }
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Find company or ticket"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.layer.cornerRadius = 20
        searchBar.layer.borderWidth = 1
        searchBar.searchTextField.backgroundColor = UIColor.white // Text field background color
        searchBar.searchTextField.textColor = UIColor.black
        return searchBar
    }()
    
    let menuBar: UIView = {
        return PrimaryMenu()
    }()
    
    
    let tableView = UITableView()
    
    func setupTableView(){
        tableView.register(CustomStockCell.self, forCellReuseIdentifier: CustomStockCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as? CustomStockCell else {
            return UITableViewCell()
            }
        
        cell.setCellColor(i: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 68
    }
    
    
    
}

