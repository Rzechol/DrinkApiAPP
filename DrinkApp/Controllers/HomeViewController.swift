//
//  HomeViewController.swift
//  DrinkApp
//
//  Created by Bartosz Rzechółka on 24/08/2022.
//

import UIKit


class HomeViewController: UIViewController {
    private enum Sections: Int {
        case OrdinaryDrink = 0
        case Cocktail = 1
        case Shake = 2
        case OtherUnknow = 3
        case Vodka = 4
        case Shot = 5
        case CoffeTea = 6
        case HomemadeLiquer = 7
        case PunchPartyDrink = 8
        case Beer = 9
        case SoftDrink = 10
        case NonAlcoholic = 11
    }
    
    private let homeFeedTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    let sectionTitles = ["Ordinary Drink", "Cocktail", "Shake", "Other / Unknow", "Vodka", "Shot", "Coffe / Tea", "Homemade Liquer", "Punch / Party Drink",  "Beer", "Soft Drink", "Non Alcoholic"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(homeFeedTableView)
        
        homeFeedTableView.delegate = self
        homeFeedTableView.dataSource = self
        
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTableView.frame = view.bounds
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
    
        cell.delegate = self
        
        switch indexPath.section {
            
            
        case Sections.OrdinaryDrink.rawValue:
            APICaller.shared.getCocktails(byCategory: .ordinary) { result in
                switch result {
                case .success(let cocktails):
                    cell.configure(with: cocktails)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.Cocktail.rawValue:
            APICaller.shared.getCocktails(byCategory: .cocktail) { result in
                switch result {
                case .success(let cocktails):
                    cell.configure(with: cocktails)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.Shake.rawValue:
            APICaller.shared.getCocktails(byCategory: .shake) { result in
                switch result {
                case .success(let cocktails):
                    cell.configure(with: cocktails)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.OtherUnknow.rawValue:
            APICaller.shared.getCocktails(byCategory: .other) { result in
                switch result {
                case .success(let cocktails):
                    cell.configure(with: cocktails)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.Vodka.rawValue:
            APICaller.shared.getCocktails(containing: "Vodka") { result in
                switch result {
                case .success(let cocktails):
                    cell.configure(with: cocktails)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.Shot.rawValue:
            APICaller.shared.getCocktails(byCategory: .shot) { result in
                switch result {
                case .success(let cocktails):
                    cell.configure(with: cocktails)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.CoffeTea.rawValue:
            APICaller.shared.getCocktails(byCategory: .coffeeOrTea) { result in
                switch result {
                case .success(let cocktails):
                    cell.configure(with: cocktails)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.HomemadeLiquer.rawValue:
            APICaller.shared.getCocktails(byCategory: .homemadeLiqueur) { result in
                switch result {
                case .success(let cocktails):
                    cell.configure(with: cocktails)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.PunchPartyDrink.rawValue:
            APICaller.shared.getCocktails(byCategory: .party) { result in
                switch result {
                case .success(let cocktails):
                    cell.configure(with: cocktails)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.Beer.rawValue:
            APICaller.shared.getCocktails(byCategory: .beer) { result in
                switch result {
                case .success(let cocktails):
                    cell.configure(with: cocktails)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.SoftDrink.rawValue:
            APICaller.shared.getCocktails(byCategory: .soft) { result in
                switch result {
                case .success(let cocktails):
                    cell.configure(with: cocktails)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.NonAlcoholic.rawValue:
            APICaller.shared.getCocktails(byAlcoholCategory: .nonAlcoholic) { result in
                switch result {
                case .success(let cocktails):
                    cell.configure(with: cocktails)
                case .failure(let error):
                    print(error)
                }
            }
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCell(_ cell: CollectionViewTableViewCell, selectedCocktail: Cocktail) {
        DispatchQueue.main.async {
            let detailVC = CocktailDetailViewController()
            detailVC.configure(with: selectedCocktail)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
