import Foundation
import UIKit

protocol PrimaryMenuDelegate{
    func favListButtonPressed(with isPressed: Bool)
}


class PrimaryMenu: UIView {
    
    var delegate:PrimaryMenuDelegate?
    var favListButtonIsActive: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stocksButton)
        self.addSubview(favButton)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeAttributedString(for title: String, isSelected: Bool) -> NSAttributedString {
        let font: UIFont
        let color: UIColor
        let lineHeight: CGFloat
        
        if isSelected {
            font = UIFont.boldSystemFont(ofSize: 28)
            color = .black
            lineHeight = 32
        } else {
            font = UIFont.systemFont(ofSize: 18)
            color = .gray
            lineHeight = 24
        }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color
        ]
        
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    @objc func stocksButtonTapped(){
        if(!stocksButton.isSelected){
            favListButtonIsActive = false
            delegate?.favListButtonPressed(with: self.favListButtonIsActive)
            stocksButton.isSelected.toggle()
            favButton.isSelected.toggle()
            stocksButton.isUserInteractionEnabled.toggle()
            favButton.isUserInteractionEnabled.toggle()
        }
    }
    
    @objc func favouritesButtonTapped(){
        if(!favButton.isSelected){
            favListButtonIsActive  = true
            delegate?.favListButtonPressed(with: self.favListButtonIsActive)
            stocksButton.isSelected.toggle()
            favButton.isSelected.toggle()
            stocksButton.isUserInteractionEnabled.toggle()
            favButton.isUserInteractionEnabled.toggle()
        }
    }
    
    // MARK: - UI Items
    
    
    lazy var stocksButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isSelected = true
        button.isUserInteractionEnabled = false
        
        let selectedAttribute = makeAttributedString(for: "Stocks", isSelected: true)
        let notSelectedAttribute = makeAttributedString(for: "Stocks", isSelected: false)
        
        button.setAttributedTitle(selectedAttribute, for: .selected)
        button.setAttributedTitle(notSelectedAttribute, for: .normal)
        
        button.addTarget(self, action: #selector(stocksButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var favButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isSelected = false
        button.isUserInteractionEnabled = true
        
        let selectedAttribute = makeAttributedString(for: "Favourite", isSelected: true)
        let notSelectedAttribute = makeAttributedString(for: "Favourite", isSelected: false)
        
        button.setAttributedTitle(selectedAttribute, for: .selected)
        button.setAttributedTitle(notSelectedAttribute, for: .normal)
        button.addTarget(self, action: #selector(favouritesButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    // MARK: - Layouts
    
    
    func setupLayouts(){
        NSLayoutConstraint.activate([
            stocksButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            stocksButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stocksButton.rightAnchor.constraint(equalTo: favButton.leftAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            favButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            favButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            favButton.leftAnchor.constraint(equalTo: stocksButton.rightAnchor, constant: 20)
        ])
        
    }
}
