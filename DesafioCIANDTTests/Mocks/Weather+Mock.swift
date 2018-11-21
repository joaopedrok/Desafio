@testable import DesafioCIANDT
import Foundation

extension Weather {
    static func mock() -> Weather {
        return Weather(identifier: 1, main: "Cloud", description: "Rainy Day", icon: "04D")
    }
}
