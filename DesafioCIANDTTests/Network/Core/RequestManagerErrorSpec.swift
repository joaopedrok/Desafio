@testable import DesafioCIANDT
import Nimble
import Quick

class RequestManagerErrorSpec: QuickSpec {
    override func spec() {
        describe("RequestManagerError") {
            it("should return the properly message for unknown") {
                expect(RequestManagerError.unknown.localizedDescription).to(equal("Unknown error"))
            }

            it("should return the properly message for invalidResponse") {
                expect(RequestManagerError.invalidResponse.localizedDescription).to(equal("Fail to serialize response"))
            }

            it("should return the properly message for responseDataNil") {
                expect(RequestManagerError.responseDataNil.localizedDescription).to(equal("Data is nil in response"))
            }
        }
    }
}
