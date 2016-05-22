//
//  WishCreationProtocols.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

public enum WishCreationError {
    case UnknowError
    case ServerError
}

protocol WishCreationWireframeProtocol : class {
    
}

protocol WishCreationViewProtocol : class {
    var presenter: WishCreationPresenterProtocol? { get set }
    func showAlert(title: String, description: String)
    func wishCreationSuccess(wish: Wish)
}

protocol WishCreationPresenterProtocol : class {
    var interactor: WishCreationInteractorInputProtocol? { get set }
    var wireframe: WishCreationWireframeProtocol? { get set }
    
    var view: WishCreationViewProtocol? { get set }
    
    func sendWish(image: UIImage, description: String, price: Double)
}

protocol WishCreationInteractorInputProtocol : class {
    weak var presenter: WishCreationInteractorOutputProtocol? { get set }
    weak var service: WishCreationServiceProtocol? { get set }
    func createWish(wish: Wish)
}

protocol WishCreationInteractorOutputProtocol : class {
    func didCreateWish(wish: Wish)
    func didFail()
}

protocol WishCreationServiceProtocol: class {
    weak var output: WishCreationServiceOutputProtocol? {get set}
    func createWish(wish: Wish)
}

protocol WishCreationServiceOutputProtocol: class {
    func didCreateWish(wish: Wish)
    func didFail(error: WishCreationError)
}