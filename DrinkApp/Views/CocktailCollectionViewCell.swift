//
//  CocktailCollectionViewCell.swift
//  DrinkApp
//
//  Created by Bartosz Rzechółka on 24/08/2022.
//

import UIKit
import SDWebImage

class CocktailCollectionViewCell: UICollectionViewCell {
    static let identifier = "CocktailCollectionViewCell"
    
    private let cocktailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let cocktailNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cocktailImageView)
        cocktailImageView.addSubview(cocktailNameLabel)
        cocktailImageView.bringSubviewToFront(cocktailNameLabel)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cocktailImageView.frame = contentView.bounds
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            cocktailNameLabel.bottomAnchor.constraint(equalTo: cocktailImageView.bottomAnchor),
            cocktailNameLabel.widthAnchor.constraint(equalTo: cocktailImageView.widthAnchor),
            cocktailNameLabel.centerXAnchor.constraint(equalTo: cocktailImageView.centerXAnchor)
            ])
    }
    
    func configure(with cocktail: Cocktail) {
        guard let imageURL = URL(string: cocktail.imageURL) else { return }
        cocktailImageView.sd_setImage(with: imageURL)
        cocktailNameLabel.text = cocktail.name
    }
}

