import AEXML
import Foundation

public extension XCScheme {
    class Runnable: Equatable {
        // MARK: - Attributes

        public var runnableDebuggingMode: String
        public var buildableReference: BuildableReference?

        // MARK: - Init

        public init(buildableReference: BuildableReference?,
                    runnableDebuggingMode: String = "0") {
            self.buildableReference = buildableReference
            self.runnableDebuggingMode = runnableDebuggingMode
        }

        init(element: AEXMLElement) throws {
            runnableDebuggingMode = element.attributes["runnableDebuggingMode"] ?? "0"
            buildableReference = try? BuildableReference(element: element["BuildableReference"])
        }

        // MARK: - XML

        func xmlElement() -> AEXMLElement {
            let element = AEXMLElement(name: "Runnable",
                                       value: nil,
                                       attributes: ["runnableDebuggingMode": runnableDebuggingMode])
            if let buildableReference {
                element.addChild(buildableReference.xmlElement())
            }
            return element
        }

        // MARK: - Equatable

        func isEqual(other: Runnable) -> Bool {
            runnableDebuggingMode == other.runnableDebuggingMode &&
                buildableReference == other.buildableReference
        }

        public static func == (lhs: Runnable, rhs: Runnable) -> Bool {
            lhs.isEqual(other: rhs) && rhs.isEqual(other: lhs)
        }
    }
}
