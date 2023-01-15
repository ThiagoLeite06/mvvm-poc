//
//  ViewModel.swift
//  MVVMPoc
//
//  Created by Thiago Almeida Leite on 14/01/23.
//

import Foundation

protocol ViewModelProtocol {
    var showLoading: (() -> Void)? {get set}
    var showMessage: ((String) -> Void)? {get set}
    var hideLoading: (() -> Void)? {get set}
    
    func getRandomJoke()
}

class ViewModel: ViewModelProtocol {
    
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    var showMessage: ((String) -> Void)?
    
    private let service = Service.shared
    
    func getRandomJoke() {
        showLoading?()
        service.getRandomJoke { [weak self] result in
            self?.hideLoading?()
            switch result {
            case .success(let model):
                self?.showMessage?(model.value)
            case .failure(let error):
                self?.showMessage?(error.localizedDescription)
            }
            
        }
    }
   
}
