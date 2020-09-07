//
//  MainParkViewController.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 23/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import UIKit

class MainParkViewController: UIViewController {

    var tableView: UITableView!
    var viewModel: MainParkViewModel?
    let sceneDelegate = SceneDelegate()
    
    init(withViewModel viewModel: MainParkViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        viewModel?.delegate = self
        setupNavbar()
        setupTableView()
        setupConstraints()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.loadVechicles()
        tableView.deselectSelectedRow(animated: true)
    }
    
    private func setupNavbar() {
        self.navigationItem.title = viewModel!.navigationTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(callParkingVehicle))
    }
    
    @objc private func callParkingVehicle() {
        let vc = sceneDelegate.container.resolve(ParkingVehicleViewController.self)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VehicleCell.self, forCellReuseIdentifier: viewModel!.cellId)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor)
        ])
    }
}

//MARK: - TableView DataSource
extension MainParkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel!.vechicles.count
        
        if count == 0 {
            tableView.setEmptyMessage(viewModel!.emptyListMessage)
        } else {
            tableView.restore()
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel!.cellId) as! VehicleCell
        cell.vehicle = viewModel!.vechicles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

//MARK: - TableView Delegate
extension MainParkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let vehicle = viewModel!.vechicles[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            let alert = UIAlertController(title: "Delete vehicle", message: "Are you sure you want to remove the vehicle from the parking?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) { (_) in
                self.viewModel?.allowExitVehicle(vehicle)
                let alert = UIAlertController(title: "Total to pay!", message: self.viewModel!.message, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                self.present(alert, animated: true, completion: nil)
                alert.addAction(ok)
            }
            let cancel = UIAlertAction(title: "CANCEL", style: .destructive, handler: nil)
            alert.addAction(ok)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
        deleteAction.backgroundColor = .red
        tableView.deselectRow(at: indexPath, animated: false)
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension MainParkViewController: MainParkViewModelDelegate {
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
