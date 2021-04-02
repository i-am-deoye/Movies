

import Foundation

protocol IRemoteRepository : IRestful {
    var httpBody : HTTPBodyType { get set }
}


extension IRemoteRepository  {
    
    fileprivate var headers : Headers {
        let object = Headers()
        return object
    }
    
    func get(url: String, handle: @escaping ((Response) -> Void) ) {
        executeConnection(uri: url, method: WebMethod.GET, payload: nil, httpBody: httpBody, headers: headers, handle: handle)
    }
    
    
    fileprivate func executeConnection(uri: String,
                                                     method: WebMethod,
                                                     payload: JSON?,
                                                     httpBody: HTTPBodyType,
                                                     headers: Headers, handle: @escaping ((Response) -> Void)) {
        
        Utilities.threadBackground {
            do {
                
                let connection = DefaultConnection()
                
               
                try connection.connect(uri: uri,
                                       method: method,
                                       payload: nil,
                                       httpBody: httpBody,
                                       headers: headers,
                                       completion: { response in
                        Utilities.threadMain {
                            handle(response)
                        }
                   })
            } catch {
                let response = Response.error(error.localizedDescription)
                handle(response)
            }
        }
        
    }
}
