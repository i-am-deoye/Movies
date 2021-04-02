

import Foundation


public enum HTTPBodyType {
    case payload, parameter
}

class DefaultConnection: NSObject, URLSessionDataDelegate {
    private var completionHandler:((Response) -> Void)?
    private var cacheDuration: Int?
    private var data: Data
    
    
    override init() {
        data = Data()
        super.init()
    }
    
    convenience init(cacheDuration: Int? = nil) {
        self.init()
        self.cacheDuration = cacheDuration
    }
    
    func connect(uri: URLConvertible,
                 method: WebMethod,
                 payload: JSON?,
                 httpBody: HTTPBodyType,
                 headers: HTTPHeaders?,
                 completion: ((Response) -> ())?) throws {
        
        self.completionHandler = completion
        guard let uri = uri.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL.init(string: uri) else { return  }
        
        
        var request = URLRequest.init(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 1200)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if payload != nil {
            request.httpBody = nil
        }
        
        
        let config = URLSession.shared.configuration
        // make the memory and disk Cache 10MB each
        config.urlCache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 10 * 1024 * 1024, diskPath: nil)
        let queue = URLSession.shared.delegateQueue
        // let urlSession = URLSession.shared
        
        let session = URLSession(configuration: config, delegate: self, delegateQueue: queue)
        let task = session.dataTask(with: request)
        task.resume()
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.data.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        DispatchQueue.main.async {
            
            
            
            if let response = task.response {
                print("RESPONSE : \(response)")
            }
            
            
            var response : Response!
            do {
                
                
                if let json = try JSONSerialization.jsonObject(with: self.data, options: .allowFragments) as? JSON {
                    response = map(json: json)
                } else {
                    response = Response.error("Empty Payload")
                }
            } catch {
                response = Response.error("We are faithfully working on this cause. Please try again later.")
            }
            
            guard let handler =  self.completionHandler else { return }
            handler(response)
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {
        
        if let cacheDuration = cacheDuration, dataTask.currentRequest?.cachePolicy == .useProtocolCachePolicy {
            let newResponse = proposedResponse.response(withExpirationDuration: cacheDuration)
            completionHandler(newResponse)
        }else {
            completionHandler(proposedResponse)
        }
    }
    
}



extension CachedURLResponse {
    func response(withExpirationDuration duration: Int) -> CachedURLResponse {
        var cachedResponse = self
        if let httpResponse = cachedResponse.response as? HTTPURLResponse, var headers = httpResponse.allHeaderFields as? [String : String], let url = httpResponse.url{
            headers["Cache-Control"] = "max-age=\(duration)"
            headers.removeValue(forKey: "Expires")
            headers.removeValue(forKey: "s-maxage")
            
            if let newResponse = HTTPURLResponse(url: url, statusCode: httpResponse.statusCode, httpVersion: "HTTP/1.1", headerFields: headers) {
                cachedResponse = CachedURLResponse(response: newResponse, data: cachedResponse.data, userInfo: headers, storagePolicy: cachedResponse.storagePolicy)
            }
        }
        return cachedResponse
    }
}
