//
//  UserDetailViewController.swift
//  Coding Test
//
//  Created by Memo on 3/28/21.
//

import UIKit
import MapKit

class UserDetailViewController: MVVMViewController<UserDetailViewModel> {
    
    weak var containerView: UIView!
    weak var emailLabel: UITextView!
    weak var phoneLabel: UITextView!
    weak var cellLabel: UITextView!
    weak var titleLabel: UILabel!
    weak var mapView: MKMapView!
    
    override func loadView() {
        super.loadView()
        
        let containerView = UIView()
        let emailLabel = UITextView()
        let phoneLabel = UITextView()
        let cellLabel = UITextView()
        let titleLabel = UILabel()
        let mapView = MKMapView()
        
        [containerView,
         mapView].forEach { view.addSubview($0) }
        
        [emailLabel,
         phoneLabel,
         cellLabel,
         titleLabel].forEach { containerView.addSubview($0) }
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(containerView).inset(20)
            $0.top.equalTo(containerView).offset(20)
        }
        
        emailLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(containerView).inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.height.equalTo(30)
        }
        
        phoneLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(containerView).inset(20)
            $0.top.equalTo(emailLabel.snp.bottom).offset(5)
            $0.height.equalTo(30)
        }
        
        cellLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(containerView).inset(20)
            $0.top.equalTo(phoneLabel.snp.bottom).offset(5)
            $0.height.equalTo(30)
        }
        
        mapView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(20)
            $0.top.equalTo(containerView.snp.bottom).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        self.containerView = containerView
        self.emailLabel = emailLabel
        self.phoneLabel = phoneLabel
        self.cellLabel = cellLabel
        self.titleLabel = titleLabel
        self.mapView = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        
        viewModel.setup()
        
        navigationItem.title = viewModel.userNameText
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .label
        
        view.backgroundColor = .tertiarySystemBackground
        
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .secondarySystemBackground
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textColor = UIColor.label
        titleLabel.text = "Datos de contacto"
        
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        emailLabel.isEditable = false
        emailLabel.isScrollEnabled = false
        emailLabel.dataDetectorTypes = .all
        emailLabel.backgroundColor = .clear
        emailLabel.tintColor = .tertiaryLabel
        emailLabel.attributedText = viewModel.emailText
        
        phoneLabel.font = UIFont.systemFont(ofSize: 14)
        phoneLabel.isEditable = false
        phoneLabel.isScrollEnabled = false
        phoneLabel.dataDetectorTypes = .all
        phoneLabel.backgroundColor = .clear
        phoneLabel.tintColor = .tertiaryLabel
        phoneLabel.attributedText = viewModel.phoneText
        
        cellLabel.font = UIFont.systemFont(ofSize: 14)
        cellLabel.isEditable = false
        cellLabel.isScrollEnabled = false
        cellLabel.dataDetectorTypes = .all
        cellLabel.backgroundColor = .clear
        cellLabel.tintColor = .tertiaryLabel
        cellLabel.attributedText = viewModel.cellText
        
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.setCenter(viewModel.coordinates, animated: true)
        mapView.layer.cornerRadius = 10
        
        userAnnotation()
    }
}

private extension UserDetailViewController {
    func userAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.title = viewModel.userNameText
        annotation.subtitle = viewModel.address
        annotation.coordinate = viewModel.coordinates
        mapView.addAnnotation(annotation)
    }
}

extension UIViewController {
    
    func showUserDetailViewController(user: User) {
        let viewModel = UserDetailViewModel(user: user)
        let controller = UserDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}
