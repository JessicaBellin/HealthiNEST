

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitles: String
    let background: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(Color)

            VStack {
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
                    .bold

                Text(subtitles)
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
            }
            .padding(.top, 80)
        }
        .frame  (width: UIScreen.main.bounds.width * 3,
                 height: 350)
        .offset(y: -150)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView  (title: "Title",
                     subtitles: "Subtitles",
                     background: .blue)
    }
}