//
//  CustomStockCell.swift
//  StocksApp
//
//  Created by Нурбол Мухаметжан on 25.01.2024.
//

import Foundation
import UIKit



protocol CustomStockCellDelegate{
    func favButtonPressed(with abbrevText:String)
}


class CustomStockCell: UITableViewCell{
    var favButtonIsActive: Bool = false
    var delegate:CustomStockCellDelegate?
    static let identifier = "stockCell"
    
    
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
    
    
    func setCellColor(i:Int){
        if(i%2 != 0){
            self.backgroundColor =  .white
        }else{
            self.backgroundColor =  UIColor(red: 0.941, green: 0.955, blue: 0.97, alpha: 1)
        }
    }
    
    func setupCellData(data:CellModel?){
        guard let data=data else{
            return
        }
        ticker.text = data.ticker
        companyName.text = data.name
        updateFavoriteButton(isFavorite: data.isFavourite ?? false)

    }
    
    
    @objc func favButtonPressed(){
        delegate?.favButtonPressed(with: self.ticker.text!)
        favButtonIsActive.toggle()
        updateFavoriteButton(isFavorite: favButtonIsActive)
    }
    
    func updateFavoriteButton(isFavorite: Bool) {
        if favButtonIsActive {
            favButton.setImage(UIImage(named: "favButtonActive"), for: .normal)
        } else {
            favButton.setImage(UIImage(named: "favButtonInactive"), for: .normal)
        }
    }
    
    // MARK: - UI Items
    
    let logo: UIImageView = {
        let imageView  = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Kaspi")
        return imageView
    }()
    
    let ticker: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "default"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let companyName: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Default Company"
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    let favButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.isUserInteractionEnabled = true
        button.setImage(UIImage(named: "favButtonInactive"), for: .normal)
        button.addTarget(self, action: #selector(favButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "default"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    let dayDelta: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "default"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .green
        
        return label
    }()
    
    // MARK: - Layout setups
    
    func setupViews(){
        self.backgroundColor = UIColor(red: 0.941, green: 0.955, blue: 0.97, alpha: 1)
        self.addSubview(logo)
        self.addSubview(ticker)
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
            companyName.topAnchor.constraint(equalTo: ticker.bottomAnchor),
            companyName.leftAnchor.constraint(equalTo: logo.rightAnchor, constant: 12),
            companyName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
        ])
        
        NSLayoutConstraint.activate([
            price.centerYAnchor.constraint(equalTo: ticker.centerYAnchor),
            price.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            dayDelta.centerYAnchor.constraint(equalTo: companyName.centerYAnchor),
            dayDelta.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            
        ])
        
        NSLayoutConstraint.activate([
            favButton.centerYAnchor.constraint(equalTo: ticker.centerYAnchor),
            favButton.leftAnchor.constraint(equalTo: ticker.rightAnchor, constant: 6)
            
        ])
        //
        NSLayoutConstraint.activate([
            ticker.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            ticker.leftAnchor.constraint(equalTo: logo.rightAnchor, constant: 12),
            ticker.heightAnchor.constraint(equalToConstant: 24)
            
        ])
        
    }
    
}


