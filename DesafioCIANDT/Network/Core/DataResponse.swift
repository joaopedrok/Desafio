import Foundation

struct DataResponse<T> {
    let result: Result<T>
    let response: HTTPURLResponse?
}
