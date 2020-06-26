import Foundation

enum ErrorsCodes: Int {
    
    case generalError = 400
    case tokenError = 401
    case validationError = 422
    case upgradeRequiredError = 426
    case codableError = 427
    case castError = 428
    case requestFailureError = 429
}
