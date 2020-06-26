import Foundation
import Alamofire

class RequestManager {
    // single tone :D
    static let sharesInstance = RequestManager()
    // this func only for sending data and reciving
    func request<T: Codable>(fromUrl url: String, byMethod method: HTTPMethod, withParameters parameters: [String:Any]?, andHeaders headers: HTTPHeaders?, completion: @escaping CompletionHandler<T>) {
        print("API URL: \(url)")
        AF.request(url, method: method, parameters: parameters,encoding:JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            let code  = response.response?.statusCode ?? -1
            let result = response.result
            print(result)
            let error = "Oops Error Please Try Again"
            switch result {
            case .success( _):
                if code == 200 || code == 201 || code == 203 {
                    self.handleSuccess(response: response, completion: completion, code: code)
                }else {
                    self.handleError(response: response, completion: completion, code: code, error: error)
                }
                break
            case .failure(let error):
                completion(error.localizedDescription,ErrorsCodes.requestFailureError.rawValue,nil)
                break
            }
        }
    }
   
    private func handleSuccess<T: Decodable>(response: AFDataResponse<Any>, completion: @escaping CompletionHandler<T>,code:Int) {
        guard let _data = response.data else {
            completion("error occured while handling data, please try again later",ErrorsCodes.castError.rawValue,nil)
            return
        }
        do{
            let data = try JSONDecoder().decode(T.self, from: _data)
            print(data)
            completion(nil, code ,data)
        } catch {
            completion("error in decoding, please try again later \(error.localizedDescription)",ErrorsCodes.codableError.rawValue,nil)
        }
    }
    
    private func handleError<T: Decodable>(response: AFDataResponse<Any>, completion: @escaping CompletionHandler<T>,code:Int,error:String) {
        guard let _data = response.data else {
            completion("error occured while handling data, please try again later",ErrorsCodes.castError.rawValue,nil)
            return
        }
        do{
            let data = try JSONDecoder().decode(T.self, from: _data)
            print(data)
            completion(error , code , data)
        } catch{
            completion("error in decoding, please try again later \(error.localizedDescription)",ErrorsCodes.codableError.rawValue,nil)
        }
    }
}
