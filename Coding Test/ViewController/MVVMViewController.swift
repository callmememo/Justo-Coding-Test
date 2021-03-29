//
//  MVVMViewController.swift
//  Coding Test
//
//  Created by Memo on 3/28/21.
//

import Foundation
import UIKit

protocol MVVMViewControllerProtocol: class {
    associatedtype T
    
    init(viewModel: T)
}

class MVVMViewController<U>: UIViewController, MVVMViewControllerProtocol {
    
    typealias T = U
    var viewModel: T
    
    convenience init() {
        fatalError("init() has not been implemented")
    }
    
    required init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MVVMCollectionViewController<U>: UICollectionViewController, MVVMViewControllerProtocol {
    
    typealias T = U
    var viewModel: T
    
    convenience init() {
        fatalError("init() has not been implemented")
    }
    
    required init(viewModel: T) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


