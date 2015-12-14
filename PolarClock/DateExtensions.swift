import Foundation

extension Int {

    func seconds() -> Int {
        return self
    }

    func minutesToSeconds() -> Int {
        return self * 60
    }

    func hoursToSeconds() -> Int {
        return self.minutesToSeconds() * 60
    }

    func daysToSeconds() -> Int {
        return self.hoursToSeconds() * 24
    }
}
