//
//  StoreWebService.swift
//  TP_geoloc
//
//  Created by Julien Guillan on 18/11/2020.
//

import Foundation
import MapKit

class StoreWebService {
    
    let API_URL = "https://moc4a-poi.herokuapp.com"
    
    func getStores(completion: @escaping ([Store]) -> Void) -> Void {
        guard let storesURL = URL(string: API_URL + "/stores") else {
            return
        }
        let task = URLSession.shared.dataTask(with: storesURL) { (data: Data?, res, err) in
            guard let bytes = data, err == nil, let json = try? JSONSerialization.jsonObject(with: bytes, options: .allowFragments) as? [Any] else {
                return
            }
            let stores = json.compactMap { (obj) -> Store? in
                guard let dict = obj as? [String: Any] else {
                    return nil
                }
                return StoreFactory.storeFrom(dictionnary: dict)
            }
            DispatchQueue.main.sync {
                completion(stores)
            }
        }
        task.resume()
    }
}
