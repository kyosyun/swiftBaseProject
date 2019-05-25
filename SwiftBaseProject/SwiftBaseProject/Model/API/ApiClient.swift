//
//  ApiClient.swift
//  SwiftBaseProject
//
//  Created by 許　駿 on 2019/05/25.
//  Copyright © 2019年 kyo_s. All rights reserved.
//

import Foundation
import Alamofire

class ApiClient {
    func baseURL() -> String {
        #if DEBUG
        //ローカルテスト環境
        return "https://hogehoge"
        #else
        //本番環境
        return "https://hogehoge"
        #endif
    }

    func subURL() -> String { return "" }

    let jsonHeaders: HTTPHeaders = [
        "Contenttype": "application/json"
    ]

    func getURLGETComponents(subURL: String?) -> URLComponents {
        let url = URLComponents(string: (self.baseURL() + self.subURL()))
        return url!
    }

    func getURLPOSTRequest(subURL: String?) -> URLRequest {
        let url = URLComponents(string: (self.baseURL() + self.subURL()))?.url!
        var urlRequest = URLRequest(url: url!)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        return urlRequest
    }

    func log(_ response: (DataResponse<Any>)) {
        print("Request: \(String(describing: response.request))")
        print("Response: \(String(describing: response.response))")
        print("Result: \(String(describing: response.result))")

        if let json = response.result.value {
            print("JSON: \(json)")  // serialized json response
        }
    }

    func appendPicture(to: MultipartFormData, image: UIImage, imageName: String) {
        // appendPictureの処理
        to.append(UIImageJPEGRepresentation(image, 0.75)!, withName: imageName, fileName: "\(imageName).jpeg", mimeType: "image/jpeg")
    }

    func appendParam(to: MultipartFormData, key: String, value: String) {
        to.append(value.data(using: String.Encoding.utf8)!, withName: key)
    }

}

extension ApiClient {
    func request(requestEntity: RequestEntity,
                 success: @escaping (_ responseEntity: ResponseEntity?) -> Void,
                 failure: @escaping (_ error: ResponseEntity?) -> Void) {
        Alamofire.request(requestParams)
            .responseJSON {response in
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    let decoder = JSONDecoder()
                    let res: ResponseEntity? = try? decoder.decode(ResponseEntity.self, from: data)
                    success(res)
                    print("Data: \(utf8Text)")  // original server data as UTF8 String
                }
        }
    }
}

class RequestEntity: Codable {

}

class ResponseEntity: Codable {

}
