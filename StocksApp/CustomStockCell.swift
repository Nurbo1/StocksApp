//
//  CustomStockCell.swift
//  StocksApp
//
//  Created by Нурбол Мухаметжан on 25.01.2024.
//

import Foundation
import UIKit


//struct Cell{
//    var logo: String
//    var abrevv: String
//    var companyName: String
//    var price: String
//    var dayDelta: String
//    
//}


class CustomStockCell: UITableViewCell{
    
    static let identifier = "stockCell"
   // let cell = Cell(logo: <#String#>, abrevv: <#String#>, companyName: <#String#>, price: <#String#>, dayDelta: <#String#>)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        
        self.layer.cornerRadius = 24

      setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        self.backgroundColor = UIColor(red: 0.941, green: 0.955, blue: 0.97, alpha: 1)
        self.addSubview(logo)
        self.addSubview(abbrevText)
        self.addSubview(companyName)
        self.addSubview(favButton)
        self.addSubview(price)
        self.addSubview(dayDelta)
    }
    
    func setupLayouts(){
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            logo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            logo.heightAnchor.constraint(equalToConstant: 52),
            logo.widthAnchor.constraint(equalToConstant: 52)
        
        ])
        
        NSLayoutConstraint.activate([
            companyName.topAnchor.constraint(equalTo: abbrevText.bottomAnchor),
            companyName.leftAnchor.constraint(equalTo: logo.rightAnchor, constant: 12),
            companyName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
        ])
//        
        NSLayoutConstraint.activate([
            price.centerYAnchor.constraint(equalTo: abbrevText.centerYAnchor),
            price.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        ])
//        
        NSLayoutConstraint.activate([
            dayDelta.centerYAnchor.constraint(equalTo: companyName.centerYAnchor),
            dayDelta.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
        
        ])
//        
        NSLayoutConstraint.activate([
            favButton.centerYAnchor.constraint(equalTo: abbrevText.centerYAnchor),
            favButton.leftAnchor.constraint(equalTo: abbrevText.rightAnchor, constant: 6)
        
        ])
//        
        NSLayoutConstraint.activate([
            abbrevText.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            abbrevText.leftAnchor.constraint(equalTo: logo.rightAnchor, constant: 12),
            abbrevText.heightAnchor.constraint(equalToConstant: 24)
        
        ])
        
    }
    
    
    let logo: UIImageView = {
        let imageView  = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "favIcon")
        return imageView
    }()
    
    let abbrevText: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "YNDX"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let companyName: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Yandex, LLC"
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    let favButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "favIcon"), for: .normal)
        button.addTarget(self, action: #selector(favButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$72.16"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    let dayDelta: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+$ 0.12 (1,15%)"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .green
        
        return label
    }()
    
    func setCellColor(i:Int){
        if(i%2==1){
            self.backgroundColor =  .white
            
        }
    }
    
    
    
    @objc func favButtonPressed(){
        print("fav button pressed")
    }
    
}
