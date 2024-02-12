//
//  ViewController.swift
//  StonksApp
//
//  Created by Нурбол Мухаметжан on 23.01.2024.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    var dictionary: [String : CellModel] = CellModel.readJSONFile() ?? [:]
    var tableData: [String: CellModel] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupViews()
        setupLayouts()
        tableView.register(CustomStockCell.self, forCellReuseIdentifier: CustomStockCell.identifier)
        setupTableView()
        setupDelegates()
        
        tableData = dictionary
    }
    
    func setupDelegates(){
        menuBar.delegate = self
    }
    
    // MARK: - UI Items
    
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
    
    let menuBar: PrimaryMenu = {
        let menu = PrimaryMenu()
        return menu
    }()
    
    let tableView = UITableView()
    
    func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
    }
    
    
    // MARK: - Layout setup and Views
    
    
    func setupViews(){
        view.addSubview(searchBar)
        searchBar.delegate = self
        view.addSubview(menuBar)
        view.addSubview(tableView)
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
    
}

extension ViewController:CustomStockCellDelegate{
    func favButtonPressed(with ticker: String) {
        
        
    }
}

extension ViewController: PrimaryMenuDelegate{
    func favListButtonPressed(with isPressed: Bool) {
        print()
        if(isPressed){
            tableData = dictionary.filter { $0.value.isFavourite == true }
        }else{
            tableData = dictionary
        }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomStockCell.identifier, for: indexPath) as? CustomStockCell else {
            return UITableViewCell()
        }
        
        let keys = Array(tableData.keys)
        cell.setupCellData(data: tableData[keys[indexPath.row]])
        cell.setCellColor(i: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
}



