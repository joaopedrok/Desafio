@testable import DesafioCIANDT
import Nimble
import Quick

class HTTPMethodSpec: QuickSpec {
    override func spec() {
        describe("HTTPMethod") {
            it("should return POST for method post") {
                expect(HTTPMethod.post.description).to(equal("POST"))
            }

            it("shpould return GET for method get") {
                expect(HTTPMethod.get.description).to(equal("GET"))
            }
        }
    }
}
