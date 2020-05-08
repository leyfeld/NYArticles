//
//  Utils.swift
//  NYArticles
//
//  Created by Anna Vorobiova on 08.05.2020.
//  Copyright © 2020 Anna Vorobiova. All rights reserved.
//

import Foundation
import UIKit

public func showAlert(message: String, viewController: UIViewController?, actionHandler: (() -> Void)?) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
        if let unwrappedHandler = actionHandler {
            unwrappedHandler()
        }
    }))
    if #available(iOS 13.0, *) {
         alert.overrideUserInterfaceStyle = .light
    }
    viewController?.present(alert, animated: true, completion: nil)
}

public func handlingError(error: Error, viewController: UIViewController?) {
    if isInternetError(error) {
        DispatchQueue.main.async {
            showAlert(message: "The internet connection appears to be offline.", viewController: viewController, actionHandler: nil)
        }
    }
}

func isInternetError(_ error: Error) -> Bool {
    if (error as? URLError)?.code == URLError.Code.notConnectedToInternet {
        return true
    }
    return false
}
