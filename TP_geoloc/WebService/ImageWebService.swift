//
//  ImageWebService.swift
//  TP_geoloc
//
//  Created by Julien Guillan on 20/11/2020.
//

import Foundation

class ImageWebService {
    func getImage(url: String, completion: @escaping (Data) -> Void) -> Void {
        guard let imageURL = URL(string: url) else {
            return
        }
        let task = URLSession.shared.dataTask(with: imageURL) { (data: Data?, res, err) in
            guard let bytes = data, err == nil else {
                return
            }
            print(bytes)
            DispatchQueue.main.sync {
                completion(bytes)
            }
        }
        task.resume()
    }
}
