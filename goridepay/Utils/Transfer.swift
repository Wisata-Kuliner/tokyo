//
//  Transfer.swift
//  goridepay
//
//  Created by Bryanza on 12/08/21.
//  Copyright © 2021 Apple Developer Academy. All rights reserved.
//

import Foundation

class Transfer {
    
    func callHeroku(
        session: URLSession,
        address: String,
        contentType: String,
        parameters: [String: Any],
        requestMethod: String,
        completion: @escaping ([[String: Any]]
        , [String: Any], String) -> ()) {
        let url = URL(string: address)!
        var request = URLRequest(url: url)
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/" + contentType, forHTTPHeaderField: "Content-Type")
        request.httpMethod = requestMethod
//        let parameters: [String: Any] = [
//            "id": 13,
//            "name": "Jack & Jill"
//        ]
//        request.httpBody = parameters.percentEncoded()
        
        var responseString: String = ""
        var responseArray: [[String: Any]] = [[:]]
        var responseObject: [String: Any] = [:]
//        var responseArray: [String: Any] = [:]
        
        if (contentType == "json" && requestMethod != "GET") {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
//                print(error.localizedDescription)
                responseString = error.localizedDescription
                return completion(responseArray, responseObject, responseString)
            }
        }
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        request.addValue("application/" + contentType, forHTTPHeaderField: "Content-Type")

//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
//                print("error", error ?? "Unknown error")
                    responseString = "error " + error.debugDescription
                    completion(responseArray, responseObject, responseString)
                    return
            }
            
            if (contentType == "json") {
                do {
                    //create json object from data
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
//                        print(json)
                        responseObject = json
                        responseString = json.description
                        completion(responseArray, responseObject, responseString)
                        // handle json...
                    }else if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                        responseString = json.description
                        responseArray = json
                        completion(responseArray, responseObject, responseString)
                    }
                } catch let error {
//                    print(error.localizedDescription)
                    responseString = "error response = \(error.localizedDescription)"
//                    return
                    completion(responseArray, responseObject, responseString)
                }
            }else {
                responseString = String(data: data, encoding: .utf8) ?? ""
                completion(responseArray, responseObject, responseString)
//                print("responseString = \(String(describing: responseString))")
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
//                print("statusCode should be 2xx, but is \(response.statusCode)")
//                print("response = \(response)")
                responseString = "error response = \(response)"
                completion(responseArray, responseObject, responseString)
                return
            }
        })

        task.resume()
        completion(responseArray, responseObject, responseString)
    }
    
    func parseDate(createdAt: String) -> String {
        let isoDate = String(createdAt.split(separator: "+")[0])
        var dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from:isoDate)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        let finalDate = calendar.date(from:components)!
        var dayComponent    = DateComponents()
        dayComponent.day    = -7 // For removing one day (yesterday): -1
        dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        if (finalDate < calendar.date(byAdding: dayComponent, to: Date())!) {
            dateFormatter.dateFormat = "dd/MM/yy " //Specify your format that you want
        }else {
            dateFormatter.dateFormat = "EEEE"
        }
        return dateFormatter.string(from: finalDate)
    }
    
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
