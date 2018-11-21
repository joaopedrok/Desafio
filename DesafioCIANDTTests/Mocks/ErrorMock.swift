import Foundation

struct ErrorMock: Error {
    var localizedDescription: String {
        return "Error"
    }
}
