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
    
    init(withViewModel viewmodel: MainParkViewModel) {
        self.viewModel = viewmodel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupNavbar()
        setupTableView()
        setupConstraints()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    private func setupNavbar() {
        self.navigationItem.title = viewModel!.navigationTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(callParkingVehicle))
    }
    
    @objc private func callParkingVehicle() {
        let story = UIStoryboard(name: "ParkingVehicle", bundle: nil)
        let viewController = story.instantiateViewController(withIdentifier: "ParkingVehicleViewController") as! ParkingVehicleViewController
        self.navigationController?.pushViewController(viewController, animated: true)
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
        return 80
    }
}

//MARK: - TableView Delegate
extension MainParkViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
