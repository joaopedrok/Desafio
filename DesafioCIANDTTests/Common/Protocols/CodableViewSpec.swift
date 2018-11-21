@testable import DesafioCIANDT
import Nimble
import Quick

class ViewCodableView: CodableView {
    var sequence = [Int]()

    func configureViews() {
        sequence.append(1)
    }

    func buildViewHierarchy() {
        sequence.append(2)
    }

    func buildConstraints() {
        sequence.append(3)
    }
}

class CodableViewSpec: QuickSpec {
    override func spec() {
        describe("CodableView") {
            var codableView: ViewCodableView!

            beforeEach {
                codableView = ViewCodableView()
            }

            context("when setup is called") {
                beforeEach {
                    codableView.setup()
                }

                it("should call all method in properly sequence") {
                    expect(codableView.sequence[0]).to(equal(1))
                    expect(codableView.sequence[1]).to(equal(2))
                    expect(codableView.sequence[2]).to(equal(3))
                }
            }
        }
    }
}
