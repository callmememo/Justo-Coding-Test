//
//  Utils.swift
//  Coding Test
//
//  Created by Memo on 3/28/21.
//

import UIKit

class Utils {
    
    class func showAlert(in viewController: UIViewController, sourceRect: CGRect? = nil, title: String, message: String, alertActions: [UIAlertAction] = [UIAlertAction](), alertStyle: UIAlertController.Style = .alert, modalPresentation: UIModalPresentationStyle? = .popover) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        alert.modalPresentationStyle = .popover
        
        if alertActions.isEmpty {
            let closeAction = UIAlertAction(title: "Cerrar", style: .default, handler: nil)
            alert.addAction(closeAction)
        } else {
            alertActions.forEach { alert.addAction($0) }
        }
        
        if let presentationController = alert.popoverPresentationController, let sourceRect = sourceRect {
            presentationController.sourceView = viewController.view
            presentationController.sourceRect = sourceRect
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
