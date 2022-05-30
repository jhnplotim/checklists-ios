// 
//  IconPickerViewController.swift
//  Checklists
//
//  Created by John Paul Otim on 30.05.22.
//

import UIKit
import Combine
 
protocol IconPickerViewDelegate: AnyObject {
    
}

// MARK: - Class

final class IconPickerViewController: BaseUITableViewController {

    typealias ViewModel = IconPickerVM & IconPickerTransition
    
    static func create(viewModel: IconPickerViewModel) -> Self {
        let instance = makeInstance()
        instance.viewModel = viewModel

        return instance
    }

    // MARK: - Outlet
    
    // MARK: - Constant

    private enum C {
        static let reuseIdentifier = "IconRow"
        static let navigationTitle = L.Feature.Checklist.Iconpicker.title
        static let icons = [("No Icon", ""), ("Bag", "bag"), ("Shopping", "cart"), ("Money", "banknote"), ("Gift", "giftcard"),
                            ("Reminder", "alarm"), ("Eye", "eye"), ("Medicine", "pills"), ("Love", "heart"),
                            ("Brain work", "brain"), ("Hospital", "cross.case"), ("Hydrate", "drop"),
                            ("Energize", "bolt"), ("Meet someone", "person"), ("Meet people", "person.3"),
                            ("Walk", "figure.walk"), ("Arrival", "airplane.arrival"), ("Departure", "car"),
                            ("Departure", "airplane.departure"), ("Tram", "tram"), ("Ferry", "ferry"),
                            ("Bike", "bicycle"), ("Scooter", "scooter"), ("Fuel", "fuelpump"), ("Game", "gamecontroller"),
                            ("TV", "display"), ("Music", "headphones"), ("Umbrella", "umbrella"), ("Repairs", "wrench"),
                            ("Food", "fork.knife"), ("Text", "message"), ("Call", "phone"), ("Email", "envelope")]
    }

    // MARK: - Variable
    private var viewModel: ViewModel!
    private var cancellables = Set<AnyCancellable>()

}

// MARK: - Lifecycle

extension IconPickerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        viewModel.setup(viewDelegate: self)
    }

}

// MARK: - Private

extension IconPickerViewController {

    private func setupView() {
        navigationItem.title = C.navigationTitle
    }

}

// MARK: - IconPickerViewDelegate

extension IconPickerViewController: IconPickerViewDelegate {
    
}

// MARK: - UITableViewDelegate & Data source
extension IconPickerViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return C.icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.reuseIdentifier, for: indexPath)
        
        let icon = C.icons[indexPath.row]
        
        cell.textLabel?.text = icon.0
        cell.imageView?.image = UIImage(systemName: icon.1)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIcon = C.icons[indexPath.row]
        viewModel.iconSelected(selectedIcon.1)
    }
}
