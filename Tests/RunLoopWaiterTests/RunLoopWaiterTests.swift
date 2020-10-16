import XCTest
@testable import RunLoopWaiter

final class RunLoopWaiterTests: XCTestCase {
   
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    measure {
      let group = DispatchGroup()
      group.enter()
      asyncTask {
        group.leave()
      }
      group.wait()
    }
  }

  func testWaitRunloop() throws {
    // This is an example of a performance test case.
    measure {
      RunLoop.current.wait { (fulfill) in
        self.asyncTask {
          fulfill(())
        }
      }
    }
  }

  func asyncTask(completion: @escaping () -> Void) {

    print("start operation")
    DispatchQueue.global().async {
      print("done operation")
      completion()
    }

  }

  static var allTests = [
    ("testExample", testExample),
  ]
}
