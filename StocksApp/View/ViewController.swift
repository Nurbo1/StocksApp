//
//  ViewController.swift
//  StonksApp
//
//  Created by Нурбол Мухаметжан on 23.01.2024.
//

import UIKit



class ViewController: UIViewController {
    
    var tableData: [String: CellData] = [:]
    
    var primaryArray: [Stock] = Stock.readStockFile() ?? []
    
    let networking = StocksViewModel()
    
    var finalDictionary: [String: CellData] = [:]
    
    let coreData = CoreDataManager()
    
    var isSearching = false
        
    let refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()
        setupDelegates()
        loadData()
        setupRefreshConrol()
    }
    
    
    func setupDelegates(){
        menuBar.delegate = self
    }
    
    // MARK: - UI Items
    func setupUI(){
        setupViews()
        setupLayouts()
        tableView.register(CustomStockCell.self, forCellReuseIdentifier: CustomStockCell.identifier)
        setupTableView()
    }
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Find company or ticket"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.layer.cornerRadius = 20
        searchBar.layer.borderWidth = 1
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.searchTextField.textColor = UIColor.black
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    let menuBar: PrimaryMenu = {
        let menu = PrimaryMenu()
        return menu
    }()
    
    let tableView = UITableView()
    

    
    
    // MARK: - Layout setup and Views and Initial setups
    
    func loadData(){
        networking.getStockData(stockArray: primaryArray) { data in
            self.finalDictionary = data
            self.tableData = self.finalDictionary
            self.tableView.reloadData()
//            self.networking.saveStockToCoreData(with: self.finalDictionary)
        }
//        networking.cleanCoreData()
    }
    
    func setupRefreshConrol(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject){
        refreshControl.endRefreshing()
        
        if menuBar.favListButtonIsActive {
            tableData = finalDictionary.filter { $0.value.isFavourite }
        } else {
            tableData = finalDictionary
        }

        tableView.reloadData()
    }
    
    func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
    }
    
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
        finalDictionary[ticker]?.isFavourite.toggle()
        coreData.updateStockInCoreData(with: ticker, cellDataItem: finalDictionary[ticker]!)
    }
}

extension ViewController: PrimaryMenuDelegate{
    func favListButtonPressed(with isPressed: Bool) {
                if(isPressed){
                    tableData = finalDictionary.filter { $0.value.isFavourite == true }
                }else{
                    tableData = finalDictionary
                }
        self.tableView.reloadData()
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
        
        let key = Array(tableData.keys).sorted()[indexPath.row]
        
        cell.setupCellData(data: tableData[key])
        cell.setCellColor(i: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
}

extension ViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            tableData = self.finalDictionary
        }else{
            
            tableData = tableData.filter({ (key: String, value: CellData) in
                key.localizedCaseInsensitiveContains(searchText)
            })
        }
        isSearching = false
        tableView.reloadData()
    }
}




