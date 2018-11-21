import Foundation

struct Settings {
    private let appIdKey = "AppID"
    private let apiURLKey = "ApiURL"
    private let apiImageURLKey = "ApiImageURL"

    static let shared = Settings()

    let appId: String
    let apiURL: String
    let apiImageURL: String

    init() {
        if let appId = Bundle.main.infoDictionary?[appIdKey] as? String {
            self.appId = appId
        } else {
            appId = ""
        }

        if let url = Bundle.main.infoDictionary?[apiURLKey] as? String {
            apiURL = url
        } else {
            apiURL = ""
        }

        if let imageURL = Bundle.main.infoDictionary?[apiImageURLKey] as? String {
            apiImageURL = imageURL
        } else {
            apiImageURL = ""
        }
    }
}
