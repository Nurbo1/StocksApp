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
        print("sa")
        view.backgroundColor = UIColor.white
        setupViews()
        setupLayouts()
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
    }
    
    func setupViews(){
        view.addSubview(searchBar)
        searchBar.delegate = self
        view.addSubview(menuBar)
    }
    
    func setupButton(){
        
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
    


}

