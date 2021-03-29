//
//  UserDetailViewModel.swift
//  Coding Test
//
//  Created by Memo on 3/28/21.
//

import UIKit
import CoreLocation

class UserDetailViewModel {
    
    private var user: User
    
    var address: String
    var cellText: NSMutableAttributedString?
    var coordinates: CLLocationCoordinate2D
    var emailText: NSMutableAttributedString?
    var phoneText: NSMutableAttributedString?
    var userNameText: String
    
    init(user: User) {
        
        self.user = user
        self.address = user.location.fullAddress
        self.coordinates = CLLocationCoordinate2D(latitude: .zero,
                                                  longitude: .zero)
        self.userNameText = user.fullName
    }
    
    func setup() {
        
        emailText = attributedString(fullText: "Correo: \(user.email)", attributedText: "Correo:")
        phoneText = attributedString(fullText: "Teléfono: \(user.phone)", attributedText: "Teléfono:")
        cellText = attributedString(fullText: "Celular: \(user.cell)", attributedText: "Celular:")
        userNameText = user.fullName
        
        if let longitude = Double(user.location.coordinates.longitude),
           let latitude = Double(user.location.coordinates.latitude) {
            coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
}

private extension UserDetailViewModel {
    func attributedString(fullText: String, attributedText: String) -> NSMutableAttributedString {
        let mutableString = NSMutableAttributedString(string: fullText)
        mutableString.setFontForText(textToFind: attributedText, withFont: UIFont.boldSystemFont(ofSize: 14), color: .secondaryLabel)
        return mutableString
    }
}

extension NSMutableAttributedString {
    func setFontForText(textToFind: String, withFont font: UIFont, color: UIColor = UIColor.label) {
        let range: NSRange = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        addAttributes([
                        NSAttributedString.Key.font: font,
                        NSAttributedString.Key.foregroundColor: color], range: range)
    }
}
