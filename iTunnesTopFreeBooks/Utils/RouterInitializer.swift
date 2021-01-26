//
//  RouterInitializer.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 16.01.2021.
//

import UIKit

class RouterInitializer: RouterProtocol {
    static func createModule<V: ViewController, I: Interactor, P: Presenter, R: Router> (viewType: V.Type, interactor: I, presenter: P, router: R) -> V {
        let identifier = String(describing: V.self)
        let withoutVCstr = identifier.components(separatedBy: "ViewController").first ?? ""
        let view = getStoryboard(name: withoutVCstr).instantiateViewController(withIdentifier: identifier) as! V
        
        createModule(view: view, interactor: interactor, presenter: presenter, router: router)
        
        return view
    }
    
    static func createModule<V: ViewController,  I: Interactor,  P: Presenter, R: Router> (view: V, interactor: I, presenter: P, router: R) {
        view.setPresenter(presenter)
        interactor.setPresenter(presenter)
        presenter.setup(viewController: view, interactor: interactor, router: router)
    }
    
    private static func getStoryboard(name: String) -> UIStoryboard{
        return UIStoryboard(name:name,bundle: Bundle.main)
    }
}
