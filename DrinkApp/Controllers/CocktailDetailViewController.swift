//
//  CocktailDetailViewController.swift
//  DrinkApp
//
//  Created by Bartosz Rzechółka on 24/08/2022.
//

import UIKit
import SDWebImage

class CocktailDetailViewController: UIViewController {
    
    private var cocktail: Cocktail? {
        didSet {
            if let cocktail = cocktail {
                title = cocktail.name
                nameLabel.text = cocktail.name
                if let url = URL(string: cocktail.imageURL) {
                    cocktailImageView.sd_setImage(with: url)
                }
                var alcoholCategoryEmoji = ""
                
                switch cocktail.alcoholCategory {
                case .alcoholic:
                    alcoholCategoryEmoji = "🟢"
                case .nonAlcoholic:
                    alcoholCategoryEmoji = "🔴"
                case .optional:
                    alcoholCategoryEmoji = "🟢 / 🔴"
                }
                
                alcoholCategoryLabel.text = "Alcohol: \(alcoholCategoryEmoji)"
                categoryLabel.text = "Category: \(cocktail.category.rawValue)"
                glassTypeLabel.text = "Glass: \(cocktail.glass)"
                instructionsLabel.text = cocktail.instructions
            }
        }
    }
    
    
    private var keysArray: [String]  {
        Array((cocktail?.ingredients.keys)!)
    }
    
    private let cocktailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let alcoholCategoryLabel: UILabel = {
        return UILabel()
    }()
    
    private let categoryLabel: UILabel = {
        return UILabel()
    }()
    
    private let glassTypeLabel: UILabel = {
        return UILabel()
    }()
    
    private let symbolConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: UIImage.SymbolWeight.light, scale: UIImage.SymbolScale.default)
    
    
    
    private let ingredientsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: IngredientTableViewCell.identifier)
        tableView.rowHeight = 30
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private lazy var cocktailDetailsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, alcoholCategoryLabel, categoryLabel, glassTypeLabel])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 5
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let instructionsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionBarButtonPressed))
        view.addSubview(scrollView)
       // view.addSubview(favouriteButton)
        scrollView.addSubview(contentView)
        contentView.addSubview(cocktailImageView)
        contentView.addSubview(cocktailDetailsStack)
        contentView.addSubview(ingredientsTableView)
        contentView.addSubview(instructionsLabel)
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        
        applyConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        self.ingredientsTableView.heightAnchor.constraint(equalToConstant: ingredientsTableView.contentSize.height).isActive = true
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            cocktailImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            cocktailImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            cocktailImageView.heightAnchor.constraint(equalToConstant: 350),
            
            cocktailDetailsStack.topAnchor.constraint(equalTo: cocktailImageView.bottomAnchor, constant: 10),
            
            ingredientsTableView.topAnchor.constraint(equalTo: glassTypeLabel.bottomAnchor),
            ingredientsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            ingredientsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            
            instructionsLabel.topAnchor.constraint(equalTo: ingredientsTableView.bottomAnchor, constant: 20),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            instructionsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
    }
    
    func configure(with cocktail: Cocktail) {
        self.cocktail = cocktail
    }
    
  
    
    @objc func actionBarButtonPressed(_ sender: UIBarButtonItem) {
        guard let cocktail = cocktail else {
            return
        }

        let ingredientsString = "Ingredients:\n" +
        cocktail.ingredients.map { key, value in
            "\(key) - \(value)"
        }.joined(separator: "\n")
        
        let activityVC = UIActivityViewController(activityItems: [cocktailImageView.image!, cocktail.name, ingredientsString, cocktail.instructions], applicationActivities: [])
        
        present(activityVC, animated: true)
    }
}

extension CocktailDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ingredients"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktail?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientTableViewCell.identifier) as? IngredientTableViewCell else {
            return UITableViewCell()
        }
        
        let ingredient = keysArray[indexPath.row]
        cell.configure(with: ingredient, amount: cocktail?.ingredients[ingredient] ?? "")
        return cell
    }
}

