import Foundation

public func waitWithRunLoop<Result>(
  resultType: Result.Type? = nil,
  perform: @escaping (_ fullfill: @escaping (Result) -> Void) -> Void
  ) -> Result {
    RunLoop.current.wait(resultType: resultType, perform: perform)
  }

}

extension RunLoop {

  public func wait<Result>(
    resultType: Result.Type? = nil,
    perform: @escaping (_ fullfill: @escaping (Result) -> Void) -> Void
  ) -> Result {

    var result: Result!

    let runLoopModeRaw = RunLoop.Mode.default.rawValue._bridgeToObjectiveC()
    let cfRunLoop = getCFRunLoop()

    CFRunLoopPerformBlock(getCFRunLoop(), runLoopModeRaw) {
      perform { r in
        result = r
        CFRunLoopPerformBlock(cfRunLoop, runLoopModeRaw) {
          CFRunLoopStop(cfRunLoop)
        }
        CFRunLoopWakeUp(cfRunLoop)
      }

    }

    CFRunLoopWakeUp(cfRunLoop)

    CFRunLoopRun()

    return result
  }
  
}
