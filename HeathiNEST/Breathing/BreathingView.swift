import SwiftUI

struct BreathingView: View {
    @State private var isAnimating = false
    @State private var animationProgress: CGFloat = 1.0
    @State private var breatheText = ""
    @State private var breatheTextOpacity: Double = 1.0
    @State private var countdownText = ""
    @State private var timer: Timer?
    @State private var countdownTimer: Timer?
    @State private var remainingTime: TimeInterval = 2 * 60
    @State private var countdownTime = 3

    let customBlue = Color(hex: 0x7BD1DC)
    
    var body: some View {
        VStack {
            Text("2 Minute Breathing Exercise")
                .font(.system(size: 23))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding()
                .padding()
                .padding()
            
            ZStack {
                Circle()
                    .stroke(customBlue.opacity(0.2), lineWidth: 5)
                    .frame(width: 200, height: 200)
                
                Circle()
                    .trim(from: 0.0, to: animationProgress)
                    .stroke(customBlue, lineWidth: 5)
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(-90))
                
                if isAnimating {
                    Text(breatheText)
                        .font(.title)
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                        .opacity(breatheTextOpacity)
                        .animation(.easeInOut(duration: 0.3), value: breatheTextOpacity)
                } else {
                    Text(countdownText)
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
            }
            
            Text(formatTime(remainingTime))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
            
            Button(action: {
                if self.isAnimating {
                    self.stopBreathing()
                } else {
                    self.startCountdown()
                }
            }) {
                Text(self.isAnimating ? "Stop Breathing" : "Start Breathing")
                    .foregroundColor(.white)
                    .padding()
                    .background(customBlue)
                    .cornerRadius(10)
            }
            .padding()
        
            Text("Follow the text for breathing guidance")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
        }
    }
    
    func startCountdown() {
        self.countdownTime = 3
        self.countdownText = "\(countdownTime)"
        self.countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.countdownTime -= 1
            if self.countdownTime > 0 {
                self.countdownText = "\(self.countdownTime)"
            } else {
                timer.invalidate()
                self.countdownText = ""
                self.startBreathing()
            }
        }
    }
    
    func startBreathing() {
        self.isAnimating = true
        self.breatheText = "Inhale"  // Start with Inhale
        self.remainingTime = 2 * 60
        self.animationProgress = 1.0
        withAnimation(Animation.linear(duration: remainingTime)) {
            self.animationProgress = 0.0
        }
        self.animateBreathingText()
        self.startTimer()
    }
    
    func stopBreathing() {
        self.isAnimating = false
        self.timer?.invalidate()
        self.timer = nil
        self.countdownTimer?.invalidate()
        self.countdownTimer = nil
        withAnimation {
            self.animationProgress = 1.0
        }
        self.breatheText = ""
        self.remainingTime = 2 * 60
    }
    
    func animateBreathingText() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            self.changeBreathText()
        }
        // Don't call timer.fire() here to avoid immediate change
    }
    
    func changeBreathText() {
        withAnimation(.easeInOut(duration: 0.3)) {
            self.breatheTextOpacity = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.breatheText = (self.breatheText == "Inhale") ? "Exhale" : "Inhale"
            withAnimation(.easeInOut(duration: 0.3)) {
                self.breatheTextOpacity = 1
            }
        }
    }
    
    func startTimer() {
        self.countdownTimer?.invalidate()
        self.countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                self.stopBreathing()
            }
        }
    }
    
    func formatTime(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct BreathingView_Previews: PreviewProvider {
    static var previews: some View {
        BreathingView()
    }
}
