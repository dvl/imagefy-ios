//
//  WishListProtocols.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

public enum WishListError {
    case UnknowError
    case ServerError
}

protocol WishListWireframeProtocol : class {
    
}

protocol WishListViewProtocol : class {
    var presenter: WishListPresenterProtocol? { get set }
    func showAlert(title: String, description: String)
    func didGetWishes(wishes: [Wish])
}

protocol WishListPresenterProtocol : class {
    var interactor: WishListInteractorInputProtocol? { get set }
    var wireframe: WishListWireframeProtocol? { get set }
    
    var view: WishListViewProtocol? { get set }
    
    func getWishes()
}

protocol WishListInteractorInputProtocol : class {
    weak var presenter: WishListInteractorOutputProtocol? { get set }
    weak var service: WishListServiceProtocol? { get set }
    func getWishes()
}

protocol WishListInteractorOutputProtocol : class {
    func didGetWishes(wishes: [Wish])
    func didFail()
}

protocol WishListServiceProtocol: class {
    weak var output: WishListServiceOutputProtocol? {get set}
    func getWishes()
}

protocol WishListServiceOutputProtocol: class {
    func didGetWishes(wishes: [Wish])
    func didFail(error: WishListError)
}