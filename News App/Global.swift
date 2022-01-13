//
//  Global.swift
//  News App
//
//  Created by dimas pratama on 14/01/22.
//

import Foundation
import UIKit

func showMessage(vc: UIViewController, text: String?) {
    guard let text = text else { return }
    let alert = UIAlertController(title: "Alert", message: text, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
    vc.present(alert, animated: true, completion: nil)
}
