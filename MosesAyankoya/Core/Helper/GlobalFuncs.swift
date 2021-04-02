

import Foundation

func readJsonData(resource: String) -> Any? {
    do
    {
        if let file = Bundle.main.url(forResource: resource, withExtension: "json")
        {
            let data = try Data(contentsOf: file)
            let json : Any? = try JSONSerialization.jsonObject(with: data, options: [])
            return json
        }
        else
        {
            print("no file")
        }
    }
    catch let error {
        print(error.localizedDescription)
    }
    
    return nil
}
