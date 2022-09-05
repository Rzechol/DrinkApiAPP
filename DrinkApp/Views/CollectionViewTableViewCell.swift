//
//  CollectionViewTableViewCell.swift
//  DrinkApp
//
//  Created by Bartosz Rzechółka on 24/08/2022.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCell(_ cell: CollectionViewTableViewCell, selectedCocktail: Cocktail)
}

class CollectionViewTableViewCell: UITableViewCell {
    static let identifier = "CollectionViewTableViewCell"
    
    private var cocktails: [Cocktail] = []
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CocktailCollectionViewCell.self, forCellWithReuseIdentifier: CocktailCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
        addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    func configure(with cocktails: [Cocktail]) {
        self.cocktails = cocktails
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cocktails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CocktailCollectionViewCell.identifier, for: indexPath) as? CocktailCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: cocktails[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCocktail = cocktails[indexPath.row]
        APICaller.shared.getCocktailDetails(byID: selectedCocktail.id) { [weak self] result in
            switch result {
            case .success(let cocktail):
                if let strongSelf = self {
                    self?.delegate?.collectionViewTableViewCell(strongSelf, selectedCocktail: cocktail)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
