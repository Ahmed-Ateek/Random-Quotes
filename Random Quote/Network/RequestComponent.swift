import Foundation
import Alamofire
class RequestComponent {
    
    static let sharesInstance = RequestComponent()
    
    func headerComponent(_ component: [RequestHeader]) -> HTTPHeaders{
        var header = HTTPHeaders()
        for singleComponent in component {
            switch singleComponent {
                case .authorization:
                    header["Authorization"] =  "Client-ID " + "TokenHere"
                    break
                case .content:
                    header["Content-Type"] = "application/json"
                    break
                case .platform:
                    header["device_type"] = "ios"
                    break
                case .lang:
                    header["lang"] = "en"
                    break
            case .uploading:
                header["Content-Type"] = "application/x-www-form-urlencoded"
            }
        }
        return header
    }
}
 
