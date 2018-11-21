import Foundation

struct Weather: Decodable {
    let identifier: Int
    let main: String
    let description: String
    let icon: String

    var iconURL: String {
        return Settings.shared.apiImageURL + icon + ".png"
    }

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case main
        case description
        case icon
    }
}
