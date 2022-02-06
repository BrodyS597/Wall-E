//
//  NetworkController.swift
//  Wall-E
//
//  Created by Brody Sears on 2/5/22.
//

import Foundation
import UIKit.UIImage

class NetworkController {
    
    // MARK: - URL
    static private let baseURLString = "https://api.nasa.gov/mars-photos/api/v1/rovers/"
    
    // MARK: - Fetch Func
    static func fetchPhotos(roverName: String, earthDate: String, completion: @escaping ([Photo]) -> Void) {
        
        //handle URL
        guard var baseURL = URL(string: baseURLString) else { completion([]); return }
        baseURL.appendPathComponent(roverName)
        baseURL.appendPathComponent("photos")
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        //Query items
        let keyQuery = URLQueryItem(name: "api_key", value: "uWzZH8DoQu36mo581gdaDeQhljm6np81ekLyIRi9")
        let earthDate = URLQueryItem(name: "earth_date", value: earthDate)
        
        //add query items to the url
        urlComponents?.queryItems = [keyQuery, earthDate]
        
        // get our final url
        guard let finalURL = urlComponents?.url else {
            print("Unable to create the final url from \(urlComponents?.description)")
            completion([])
            return
        }
        
        //create the data task
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                print(error)
                completion([])
                return
            }
            //check for data
            guard let data = data else {
                print("No data was found")
                completion([])
                return
            }
            //deserialize the data
            do {
                //try
                if let topLevelDictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] {
                    //get the data from the dictionary
                    guard let photosDictArray = topLevelDictionary["photos"] as? [[String: Any]] else {                       completion([]); return }
                    var tempArray: [Photo] = []
                    
                    //Loop through the array
                    for dictionary in photosDictArray {
                        if let photo = Photo(dictionary: dictionary) {
                            
                            tempArray.append(photo)
                        }
                    }
                    //complete with the data
                    completion(tempArray)
                }
            } catch {
                print(error)
                completion([])
            }
        }.resume()
    } //end of func
    
    
    // MARK: - Get Image Func
    
    static func fetchImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let finalURL = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                print("Error fetching data from url\(finalURL)", error)
                completion(nil)
                return
            }
            guard let imageData = data else {
                completion(nil)
                return
            }
            let image = UIImage(data: imageData)
            completion(image)
        }.resume()
    }
}//end of class
