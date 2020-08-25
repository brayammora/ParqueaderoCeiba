//
//  VehicleCell.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 23/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import UIKit

//protocol VehicleCellDelegate {
//    func allowExitVehicle(_ vehicle: Vehicle)
//}

class VehicleCell: UITableViewCell {
    
//    var delegate: VehicleCellDelegate?
    
    var vehicle: Vehicle? {
        didSet {
            guard let vehicleItem = vehicle else {return}
            profileImageView.image = vehicleItem.type == Constants.car ? UIImage(named: "car") : UIImage(named: "motorbike")
            numberPlateLabel.text = "Number Plate: \(vehicleItem.numberPlate)"
            entryDateLabel.text = "Entry Date: \(formatDate(vehicleItem.date))"
        }
    }
    
    let profileImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
       return img
    }()
    
    let numberPlateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let entryDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    let exitImageView: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
//        btn.backgroundColor = .none
//        btn.tintColor = .black
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.contentMode = .scaleAspectFill
//        btn.layer.cornerRadius = 13
//        btn.clipsToBounds = true
//        btn.addTarget(self, action: #selector(goToMainAndAllowExitVehicle), for: .touchUpInside)
//        btn.isUserInteractionEnabled = true
//        return btn
//    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        contentView.addSubview(profileImageView)
        containerView.addSubview(numberPlateLabel)
        containerView.addSubview(entryDateLabel)
//        containerView.addSubview(exitImageView)
        contentView.addSubview(containerView)
    }
    
    private func setupConstraints() {
        
        // profile image
        profileImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // container view
        containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // number plate
        numberPlateLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        numberPlateLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        numberPlateLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        
        // entry date
        entryDateLabel.topAnchor.constraint(equalTo: self.numberPlateLabel.bottomAnchor).isActive = true
        entryDateLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        entryDateLabel.topAnchor.constraint(equalTo: self.numberPlateLabel.bottomAnchor).isActive = true
        
//        // exit button
//        exitImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
//        exitImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        exitImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant:-20).isActive = true
//        exitImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    private func formatDate (_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter.string(from: date)
    }
    
//    @objc private func goToMainAndAllowExitVehicle(_ sender: Any) {
//        guard let vehicle = vehicle else { return }
//        delegate?.allowExitVehicle(vehicle)
//    }
    
}
