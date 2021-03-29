//
//  UsersReusableView.swift
//  Coding Test
//
//  Created by Memo on 3/28/21.
//

import UIKit

class UsersReusableView: UICollectionReusableView {
    
    unowned var delegate: UsersViewControllerDelegate?
    
    private let instructionLabel = UILabel()
    private let resultTextField = UITextField()    
    
    var resultsPerPage: Int = 20 {
        didSet {
            resultTextField.placeholder = "\(resultsPerPage)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [instructionLabel,
         resultTextField].forEach { addSubview($0) }
        
        resultTextField.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.trailing.equalTo(self).offset(-10)
            $0.height.equalTo(35)
            $0.width.equalTo(100)
        }
        
        instructionLabel.snp.makeConstraints {
            $0.leading.equalTo(self).offset(10)
            $0.trailing.equalTo(resultTextField.snp.leading).offset(-10)
            $0.centerY.equalTo(self)
        }
        
        resultTextField.borderStyle = .roundedRect
        resultTextField.keyboardType = .numberPad
        resultTextField.addTarget(self, action: #selector(didFinishTyping(_:)), for: .editingDidEnd)
        
        instructionLabel.font = UIFont.boldSystemFont(ofSize: 14)
        instructionLabel.numberOfLines = 0
        instructionLabel.lineBreakMode = .byWordWrapping
        instructionLabel.textColor = UIColor.secondaryLabel
        instructionLabel.textAlignment = .left
        instructionLabel.text = "Resultados por página, cantidad mínima de 10."
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func didFinishTyping(_ textField: UITextField) {
        guard let text = textField.text, let resultsPerPage = Int(text), resultsPerPage > 10 else { return }
        delegate?.change(resultsPerPage)
    }
}

