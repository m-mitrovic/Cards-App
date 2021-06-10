//
//  MoonPhaseCardView.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-08.
//

import SwiftUI

let lat = 43.255203
let long = -79.843826

struct MoonPhaseCardView: View {
    let card: Card
    @State var smc: SunMoonCalculator? = nil
    
    var body: some View {
        GeometryReader { geo in
            if smc != nil { // Show moon widget
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(smc!.moonPhase).font(.headline)
                            Spacer()
                            VStack(alignment: .leading, spacing: -2) {
                                Text("\(Int(smc!.moonIllumination * 100))% Illum.")
                                Text("Age: \(Int(smc!.moonAge)) days")
                                
                                // Show the more recent moon event first
                                if smc!.moonSetDate.timeA > smc!.moonRiseDate.timeA {
                                    Text("Set: \(smc!.moonSetDate.timeA)").padding(.top, 8)
                                    Text("Rise: \(smc!.moonRiseDate.timeA)")
                                } else {
                                    Text("Rise: \(smc!.moonRiseDate.timeA)")
                                    Text("Set: \(smc!.moonSetDate.timeA)").padding(.top, 8)
                                }
                            }
                        }.foregroundColor(card.TextColor.color())
                        Spacer()
                        MoonView(smc: smc! , size: geo.size.height-50)
                    }
                }.padding().background(card.Background.color())
            }
        }.onAppear() {
            initialize()
        }
    }
    
    func initialize() {
        do {
            let smcM = try SunMoonCalculator(date: Date(), longitude: long, latitude: lat)
            smcM.calcSunAndMoon()
            smc = smcM
        } catch {
            print("failded")
        }
    }
}

struct PlaceholderCardView: View {
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    Capsule().frame(width: geo.size.width-30, height: 20)
                    Spacer()
                    Capsule().frame(width: geo.size.width/2, height: 20)
                    Capsule().frame(width: geo.size.width/1.65, height: 65)
                }.foregroundColor(Color.white).opacity(0.12).padding()
                
                HStack {
                    Spacer()
                    Spacer()
                }
            }
        }.background(Color.white.opacity(0.12))
    }
}

struct MoonPhaseCardView_Previews: PreviewProvider {
    static var previews: some View {
        MoonPhaseCardView(card: placeholderCard)
    }
}


extension SunMoonCalculator {
    
    var moonSetDate: Date {
        let utc = self.moonSet
        return dateFromJd(jd: utc)
    }
    
    var moonRiseDate: Date {
        let utc = self.moonRise
        return dateFromJd(jd: utc)
    }
    
}

extension Date {
    var timeA: String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mma"
        let stringDate = timeFormatter.string(from: self)
        return stringDate.uppercased()
    }
    
}

func dateFromJd(jd : Double) -> Date {
    let JD_JAN_1_1970_0000GMT = 2440587.5
    return Date(timeIntervalSince1970: (jd - JD_JAN_1_1970_0000GMT) * 86400)
}


// MARK: Moon Shadow Arch/Ellipse
// Using the efficiencies of SwiftUI paths to draw the moons shadow dependant on the illumination percentage of the moon. It took lots of trial & error, but finally the following formulas perfectly draw the moon's shadow.
// I learned about drawing shapes in SwiftUI from: https://www.hackingwithswift.com/books/ios-swiftui/paths-vs-shapes-in-swiftui

struct MoonView: View {
    var smc: SunMoonCalculator
    var size: CGFloat
    
    var body: some View {
        ZStack {
            Image("moon").resizable().scaledToFill().frame(width: size, height: size) // Moon view
            
            if (smc.moonIllumination < 0.985) {
                MoonShadowShape(archSize: shadowArch, shadowIsArch: isArch, frame: size)
                    .fill(Color.black)
                    .frame(width: size, height: size)
                    .opacity(0.915)
            }
            
        }.frame(width: size, height: size).clipShape(Circle()).rotationEffect(shadowRotation)
    }
    
    var isArch: Bool {
        if (smc.moonIllumination) > 0.49 {
            return true
        } else {
            return false
        }
    }
    
    var shadowArch: CGFloat {
        if isArch {
            return archShadow
        } else {
            return ellipseShadow
        }
    }
    
    // First half of illumination done, now second half (0-49) must be done
    var archShadow: CGFloat {
        // 0: Full-moon  -  1.5: Half-moon
        //   0.5 -> 1.5     0.8 -> 0.3
        return CGFloat(3*(1-smc.moonIllumination))
    }
    
    // Translate illumination for illumination values < 49%
    var ellipseShadow: CGFloat {
        // 0 -> 3.14    0.25 -> ~2.7
        return CGFloat(3.14*(1-smc.moonIllumination))
    }
    
    var shadowRotation: Angle {
        let baseTransition = moonBaseTranslation
        let moonAngleTransition = Angle.radians((smc.moonPar-smc.moonP)) // Gets the current moon rotation of bright limb
        return baseTransition + moonAngleTransition
    }
    
    var moonBaseTranslation: Angle { // Rotates the moon to match the moon's phase angle
        let moonAge = smc.moonAge
        if moonAge >= 15.8 && moonAge <= 28.530588853 {
            return .degrees(90)
        } else {
            return .degrees(-90)
        }
    }
}

struct MoonShadowShape: Shape {
    var archSize: CGFloat
    var shadowIsArch: Bool
    var frame: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = self.frame/2
        let angle: CGFloat = archSize // 0: none - 1.5: full
        
        if shadowIsArch { // Arch shadow
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: radius*1.05, startAngle: .radians(0), endAngle: -.radians(.pi), clockwise: true)
            
            let start = Angle.radians(.pi)
            
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY + radius * tan(angle)), radius: radius / cos(angle), startAngle: (-start + .radians(Double(angle))), endAngle: -.radians(Double(angle)), clockwise: false)
            
        } else { // ELlipse
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: radius*1.05, startAngle: -.radians(0), endAngle: -.radians(.pi), clockwise: true)
            
            let start = -Angle.radians(.pi)
            
            path.addArc(center: CGPoint(x: rect.midX, y: (rect.midY) + radius * tan(angle)), radius: radius / cos(angle), startAngle: .radians(0), endAngle: .radians(.pi), clockwise: true)
        }

        return path
    }
}
