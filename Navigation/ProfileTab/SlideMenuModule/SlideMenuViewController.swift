//
//  SlideMenuViewController.swift
//  Navigation
//
//  Created by Миша on 21.12.2021.
//

import UIKit

protocol SlideMenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: SlideMenuModel)
}

class SlideMenuViewController: UIViewController {
   
    weak var delegate: SlideMenuViewControllerDelegate?
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SlideMenuTableViewCell.self, forCellReuseIdentifier: SlideMenuTableViewCell.reuseId)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        tableView.separatorStyle = .none
        tableView.rowHeight = 90
        tableView.backgroundColor = .systemGray
    }
}

// MARK: - DataSource
extension SlideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SlideMenuModel.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SlideMenuTableViewCell.reuseId, for: indexPath) as! SlideMenuTableViewCell
        cell.myLabel.text = SlideMenuModel.allCases[indexPath.row].rawValue
        cell.myLabel.textColor = .white
        cell.iconImageView.image = SlideMenuModel.allCases[indexPath.row].image
        cell.iconImageView.tintColor = .yellow
        return cell
    }
}


// MARK: - Delegate

extension SlideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = SlideMenuModel.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
}
