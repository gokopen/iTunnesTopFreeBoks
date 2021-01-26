//
//  ViewController.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 2.01.2021.
//

import UIKit


class ViewController: UIViewController, PresenterToViewControllerProtocol {

    private var presenterBase: ViewControllerToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func getPresenter<T: ViewControllerToPresenterProtocol> (type: T.Type) -> T {
        return self.presenterBase as! T
    }
    
    func setPresenter<T: ViewControllerToPresenterProtocol> (_ newPresenter: T) {
        self.presenterBase = newPresenter
    }

}

