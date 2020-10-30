//
//  AboutCanadaViewModel.swift
//  WyndhamAssignment
//
//  Created by Amol P on 15/05/19.
//  Copyright © 2019 pccs. All rights reserved.
//

import Foundation

class AboutCanadaViewModel {
    private var aboutCanada:AboutCanada?
    
    var errorMessage:String?
    var dataUpdated:Bool = false
    
    var title:String {
        return aboutCanada?.title ?? Constants.Title.viewControllerTitle
    }
    var noOfRows:Int {
        return aboutCanada?.rows.count ?? 0
    }
    
    func getTitle(index:Int) -> String {
        return aboutCanada?.rows[index].title ?? ""
    }
    
    func getDescription(index:Int) -> String {
        return aboutCanada?.rows[index].description ?? ""
    }
    
    func getImageURLString(index:Int) -> String? {
        return aboutCanada?.rows[index].imageURL
    }
    
    func getData(url:String, completion: @escaping (Result<Bool,APiError>) -> Void) {
        APIServices.sharedAPIServices.getData(urlString: url,decodingType: AboutCanada.self) { [weak self] (result) in
            switch result {
            case .success(let value):
                print(value)
                self?.aboutCanada = AboutCanada()
                self?.aboutCanada?.title = value.title
                self?.aboutCanada?.rows = value.rows
                    .filter({ (row) -> Bool in
                    if row.title != nil, row.description != nil, row.imageURL != nil {
                        return true
                    }
                    return false
                })
                completion(Result.success(true))
                
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
