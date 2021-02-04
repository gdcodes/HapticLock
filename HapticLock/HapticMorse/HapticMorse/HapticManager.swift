import CoreHaptics

public class HapticManager {
    
    let hapticEngine: CHHapticEngine
    var relativeTime: Double = Time.start

    public init?() {
        let hapticCapability = CHHapticEngine.capabilitiesForHardware()
        
        guard hapticCapability.supportsHaptics else {
            return nil
        }

        do {
            hapticEngine = try CHHapticEngine()
        } catch let error {
            print("Engine Creation Error: \(error)")
            return nil
        }

        do {
            try hapticEngine.start()
        } catch let error {
            print("Failed to start the engine: \(error)")
        }
        
        hapticEngine.stoppedHandler = { reason in
            print("Stop Handler: The engine stopped for reason: \(reason.rawValue)")
                switch reason {
                case .audioSessionInterrupt: print("Audio session interrupt")
                case .applicationSuspended: print("Application suspended")
                case .idleTimeout: print("Idle timeout")
                case .systemError: print("System error")
                default:
                    print("Unknown error")
                }
        }

        // If something goes wrong, try to restart the engine immediately
        hapticEngine.resetHandler = { [weak self] in
            print("Reset Handler: Restarting the engine.")
            do {
                try self?.hapticEngine.start()
            } catch {
                print("Failed to restart the engine: \(error)")
            }
        }

        hapticEngine.isAutoShutdownEnabled = true
    }
}

extension HapticManager {
    
    public func playTacton(_ digit: Int) {
        do {
            let pattern = try patternFromDigit(digit)
            try playHapticFromPattern(pattern)
        } catch {
            print("Failed to play slice: \(error)")
        }
    }
    
    public func stop() {
        hapticEngine.stop(completionHandler: { (_) -> Void in
        })
    }
    
    private func playHapticFromPattern(_ pattern: CHHapticPattern) throws {
        stop()
        try hapticEngine.start()
        let player = try hapticEngine.makePlayer(with: pattern)
        try player.start(atTime: CHHapticTimeImmediate)
    }
    
    private func patternFromDigit(_ digit: Int) throws -> CHHapticPattern {
        // Reset relative time
        self.relativeTime = Time.start
        
        var events: [CHHapticEvent] = []

        switch(digit) {
        case 0:
            for _ in 1...5 {
                events.append(dashEvent(relativeTime: self.relativeTime))
            }
        case 1:
            events.append(dotEvent(relativeTime: relativeTime))
            for _ in 2...5 {
                events.append(dashEvent(relativeTime: self.relativeTime))
            }
        case 2:
            for _ in 1...2 {
                events.append(dotEvent(relativeTime: self.relativeTime))
            }
            for _ in 3...5 {
                events.append(dashEvent(relativeTime: self.relativeTime))
            }
        case 3:
            for _ in 1...3 {
                events.append(dotEvent(relativeTime: self.relativeTime))
            }
            for _ in 4...5 {
                events.append(dashEvent(relativeTime: self.relativeTime))
            }
        case 4:
            for _ in 1...4 {
                events.append(dotEvent(relativeTime: self.relativeTime))
            }
            events.append(dashEvent(relativeTime: self.relativeTime))
        case 5:
            for _ in 1...5 {
                events.append(dotEvent(relativeTime: self.relativeTime))
            }
        case 6:
            events.append(dashEvent(relativeTime: self.relativeTime))
            for _ in 2...5 {
                events.append(dotEvent(relativeTime: self.relativeTime))
            }
        case 7:
            for _ in 1...2 {
                events.append(dashEvent(relativeTime: self.relativeTime))
            }
            for _ in 3...5 {
                events.append(dotEvent(relativeTime: self.relativeTime))
            }
        case 8:
            for _ in 1...3 {
                events.append(dashEvent(relativeTime: self.relativeTime))
            }
            for _ in 4...5 {
                events.append(dotEvent(relativeTime: self.relativeTime))
            }
        case 9:
            for _ in 1...4 {
                events.append(dashEvent(relativeTime: self.relativeTime))
            }
            events.append(dotEvent(relativeTime: self.relativeTime))
        default:
            events = []
        }

        return try CHHapticPattern(events: events, parameters: [])
    }
    
    private func dotEvent(relativeTime: Double) -> CHHapticEvent {
        let event = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: Dot.intensity),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: Dot.sharpness)
            ],
            relativeTime: relativeTime,
            duration: Dot.duration)
        self.relativeTime = updateRelativeTime(relativeTime: relativeTime, duration: Dot.duration, offset: Time.offset)
        return event;
    }
    
    private func dashEvent(relativeTime: Double) -> CHHapticEvent {
        let event = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: Dash.intensity),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: Dash.sharpness)
            ],
            relativeTime: relativeTime,
            duration: Dash.duration)
        self.relativeTime = updateRelativeTime(relativeTime: relativeTime, duration: Dash.duration, offset: Time.offset)
        return event
    }
    
    private func updateRelativeTime(relativeTime: Double, duration: Double, offset: Double) -> Double {
        return relativeTime + duration + offset
    }
}
