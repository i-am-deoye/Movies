

import Foundation


private let parseError = "Unable to parse"

enum Response {
    case success(String, [Payload])
    case error(String)
}

func  map(json: JSON) ->  Response  {
    guard let mapped = Payload.map(json) else { return Response.error(parseError) }
    print(mapped)
    return Response.success("Success", [mapped])
}

