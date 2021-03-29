//
//  UsersViewController.swift
//  Coding Test
//
//  Created by Memo on 3/26/21.
//

import UIKit
import Kingfisher
import SnapKit

protocol UsersViewControllerDelegate: class {
    func change(_ resultsPerPage: Int)
}

class UsersViewController: MVVMCollectionViewController<UsersViewModel> {
    
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        configureUI()
        fetchUsers()
    }
    
    private func configureUI() {
        navigationItem.title = "Usuarios"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView?.backgroundColor = UIColor.tertiarySystemBackground
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        collectionView.register(UsersCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UsersCollectionViewCell.self))
        collectionView.register(UsersReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: UsersReusableView.self))
        collectionView.backgroundView = activityIndicator
        
        activityIndicator.hidesWhenStopped = true
    }
}

private extension UsersViewController {
    
    func errorAlert() {
        
        let retryAction = UIAlertAction(title: "Reintentar", style: .default) { _ in
            self.fetchUsers()
        }
        
        let closeAction = UIAlertAction(title: "Cerrar", style: .cancel, handler: nil)
        
        Utils.showAlert(in: self,
                        title: "Coding Test",
                        message: "Hubo un error al intentar procesar la solicitud, ¿Desea Intentarlo nuevamente?",
                        alertActions: [closeAction, retryAction])
    }
    
    func fetchUsers() {
        
        activityIndicator.startAnimating()
        viewModel.setup { [unowned self] success in
            
            self.activityIndicator.stopAnimating()
            
            guard success else {
                self.errorAlert()
                return
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension UsersViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count()
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == viewModel.count() - 2 && !viewModel.isWating {
            fetchUsers()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UsersCollectionViewCell.self), for: indexPath as IndexPath) as! UsersCollectionViewCell
        cell.user = viewModel.user(at: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: 150)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: UsersReusableView.self), for: indexPath) as! UsersReusableView
        header.delegate = self
        header.resultsPerPage = viewModel.resultsPerPage
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width,
               height: 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showUserDetailViewController(user: viewModel.user(at: indexPath.row))
    }
}

extension UsersViewController: UsersViewControllerDelegate {

    func change(_ resultsPerPage: Int) {
        viewModel.change(to: resultsPerPage)
        collectionView.reloadData()
        fetchUsers()
    }
}
