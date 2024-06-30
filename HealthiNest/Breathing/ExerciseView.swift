import SwiftUI

struct ExerciseView: View {
    @State private var isAnimating = false
    @State private var animationProgress: CGFloat = 1.0
    @State private var exerciseText = ""
    @State private var exerciseTextOpacity: Double = 1.0
    @State private var countdownText = ""
    @State private var timer: Timer?
    @State private var countdownTimer: Timer?
    @State private var remainingTime: TimeInterval = 2 * 60
    @State private var countdownTime = 3
    
    
    let customBlue = Color(hex: 0x7BD1DC)
    let exercises = [ "Neck Stretch", "Push Ups", "Jumping Jacks", "Planks"]
    let instructions = [
        "Sit or stand upright and slowly tilt your head towards your shoulder.",
        "Keep your body straight, lower your body until your chest almost touches the floor, then push back up.",
        "Jump to a position with legs spread and hands touching overhead, then return to a standing position.",
        "Hold your body in a straight line, supported by your toes and forearms."
    ]
    @State private var exerciseIndex = 0

    var body: some View {
        VStack {
            Text(exercises[exerciseIndex])
                .font(.system(size: 23))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
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
                    Text(exerciseText)
                        .font(.title)
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                        .opacity(exerciseTextOpacity)
                        .animation(.easeInOut(duration: 0.3), value: exerciseTextOpacity)
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
                    self.stopExercise()
                } else {
                    self.startCountdown()
                }
            }) {
                Text(self.isAnimating ? "Stop Exercise" : "Start Exercise")
                    .foregroundColor(.white)
                    .padding()
                    .background(customBlue)
                    .cornerRadius(10)
            }
            .padding()
        
            Text(instructions[exerciseIndex])
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
            
            Button(action: {
                self.exerciseIndex = (self.exerciseIndex + 1) % self.exercises.count
            }) {
                Image(systemName: "arrow.right.circle")
                    .font(.title)
                    .padding()
            }

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
                self.startExercise()
            }
        }
    }
    
    func startExercise() {
        self.isAnimating = true
        self.exerciseText = "Start"  // Start with Start
        self.remainingTime = 2 * 60
        self.animationProgress = 1.0
        withAnimation(Animation.linear(duration: remainingTime)) {
            self.animationProgress = 0.0
        }
        self.animateExerciseText()
        self.startTimer()
    }
    
    func stopExercise() {
        self.isAnimating = false
        self.timer?.invalidate()
        self.timer = nil
        self.countdownTimer?.invalidate()
        self.countdownTimer = nil
        withAnimation {
            self.animationProgress = 1.0
        }
        self.exerciseText = ""
        self.remainingTime = 2 * 60
    }
    
    func animateExerciseText() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            self.changeExerciseText()
        }
        // Don't call timer.fire() here to avoid immediate change
    }
    
    func changeExerciseText() {
        withAnimation(.easeInOut(duration: 0.3)) {
            self.exerciseTextOpacity = 0
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            self.exerciseText = (self.exerciseText == "Start") ? "Stop" : "Start"
//            withAnimation(.easeInOut(duration: 0.3)) {
//                self.exerciseTextOpacity = 1
//            }
//        }
    }
    
    func startTimer() {
        self.countdownTimer?.invalidate()
        self.countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                self.stopExercise()
            }
        }
    }
    
    func formatTime(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}
