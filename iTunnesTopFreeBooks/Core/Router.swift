//
//  Router.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import Foundation
import UIKit

class Router: RouterProtocol {
    static func createModule<V: ViewController, I: Interactor, P: Presenter<V,I,R>, R: Router>(viewController: V.Type, interactor: I, presenter: P, router: R) -> V {
        let identifier = String(describing: V.self)
        let withoutVCstr = identifier.components(separatedBy: "ViewController").first ?? ""
        let view = getStoryboard(name: withoutVCstr).instantiateViewController(withIdentifier: identifier) as! V
        
        setupModuleWithExistingView(view: view, interactor: interactor, presenter: presenter, router: router)
        
        return view
    }
    
    static func setupModuleWithExistingView<V: ViewController, I: Interactor, P: Presenter<V,I,R>, R: Router>(view: V, interactor: I, presenter: P, router: R) {
        view.presenter = presenter
        presenter.viewController = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
    }
    
    static func getStoryboard(name: String) -> UIStoryboard{
        return UIStoryboard(name:name,bundle: Bundle.main)
    }
    
}
