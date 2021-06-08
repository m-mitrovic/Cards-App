//
//  MoonCardView.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-01.
//

import SwiftUI

let lat = 43.255203
let long = -79.843826

struct MoonCardView: View {
    var moon = SwiftySuncalc().getMoonIllumination(date: customDate)
    var moonAngle = SwiftySuncalc().getMoonPosition(date: customDate, lat: lat, lng: long)
    var smc: SunMoonCalculator?
    
    var body: some View {
        VStack {
            Group {
            Text("Sun Moon Calc").font(.system(.headline))
                Text("Angle: \((smc?.moonPar ?? 0)*100)")
                Text("Phase: \(smc?.moonPhase ?? "mo")")
                Text("Azimoth: \(smc?.moonAzimuth.toDegrees ?? 10)")
                Text("BL Angle: \(smc?.moonBL.toDegrees ?? 10)")
                Text("Angle: \(smc?.moonPar.toDegrees ?? 10)")
                Text("Position Angle: \(smc?.moonP.toDegrees ?? 10)")
                Text("Illumina: \((smc?.moonIllumination ?? 10)*100)")
            }
            
            Spacer().frame(height: 25)
            
            Group {
                Text("Swifty Sun Calc").font(.system(.headline))
                Text(moon["angle"]!.toDegrees.description)
                Text(moonAngle["parallacticAngle"]!.toDegrees.description)
                Text("Parallactic Angle: \((moonAngle["parallacticAngle"]!.toDegrees)-90)")
                Text("Fraction: \((moon["fraction"]!)*100)%")
                Text("Phase: \((moon["phase"]!)*100)%")
            }
            
            Group {
            Spacer()
//                HStack {
//                    LunarPhaseView()
//                        .frame(width: 100, height: 100)
//                        .background(Color.green)
//                        .clipShape(Circle())
//                        .background(Color.blue)
//                        .rotationEffect(.radians((smc?.moonBL ?? 0)))
//
//                    Spacer().frame(height: 40)
//                    LunarPhaseView()
//                        .frame(width: 100, height: 100)
//                        .background(Color.green)
//                        .clipShape(Circle())
//                        .background(Color.red)
//                        .rotationEffect(.radians((moonAngle["parallacticAngle"]!.toDegrees)-90))
//                }
            
//            Spacer().frame(height: 40)
//            LunarPhaseView()
//                .frame(width: 100, height: 100)
//                .background(Color.green)
//                .clipShape(Circle())
//                .background(Color.green)
//                .rotationEffect(.radians((moon["angle"]!.toDegrees-moonAngle["parallacticAngle"]!.toDegrees)))
//
//            Spacer().frame(height: 40)
//            LunarPhaseView()
//                .frame(width: 100, height: 100)
//                .background(Color.green)
//                .clipShape(Circle())
//                .background(Color.yellow)
//                //.rotationEffect(.radians((smc?.moonPar) ?? 0))
//            }
//
//             LunarView2(illumination: (smc?.moonIllumination ?? 10))
//                .clipShape(Circle())
//                .background(Color.yellow)
//                .innerShadow(using: Circle(), angle: .degrees(100), color: Color.black, width: 100, blur: 0)
                
                
                HStack {
                    MoonView(illumination: (smc?.moonIllumination ?? 0.1), size: 80)
                        .rotationEffect(.radians((smc?.moonBL ?? 0) - 90))
                    MoonView(illumination: (smc?.moonIllumination ?? 0.1), size: 80)
                        .rotationEffect(-.radians((smc?.moonBL ?? 0)))
                    MoonView(illumination: (smc?.moonIllumination ?? 0.1), size: 80)
                        .rotationEffect(.radians((smc?.moonBL ?? 0) + 90))
                    MoonView(illumination: (smc?.moonIllumination ?? 0.1), size: 80)
                        .rotationEffect(.radians((smc?.moonBL ?? 0) - 180))
//                    MoonView(illumination: (smc?.moonIllumination ?? 0.1), size: 80)
//                        .rotationEffect(.radians((smc?.moonBL ?? 0)))
//                    MoonView(illumination: (smc?.moonIllumination ?? 0.1), size: 80)
//                        .rotationEffect(.radians((smc?.moonAzimuth) ?? 0))
//                    MoonView(illumination: (smc?.moonIllumination ?? 0.1), size: 80)
                        
                }
                
                HStack {
                    MoonView(illumination: (smc?.moonIllumination ?? 0.1), size: 80)
                        .background(Color.green)
                    MoonView(illumination: (smc?.moonIllumination ?? 0.1), size: 80)
                        .rotationEffect(.degrees(-90))
                        .rotationEffect(-.radians((smc?.moonBL ?? 0)))
                    MoonView(illumination: (smc?.moonIllumination ?? 0.1), size: 80)
                        .rotationEffect(.radians((smc?.moonAzimuth) ?? 0))
                    MoonView(illumination: (smc?.moonIllumination ?? 0.1), size: 80)
                        .rotationEffect(.radians((smc?.moonPar ?? 0)))
                }
                
                HStack {
                    MoonView(illumination: (smc?.moonIllumination ?? 0.1), size: 80)
                        .rotationEffect(.radians((smc?.moonP ?? 0)-(smc?.moonPar ?? 0)))
                    VStack {
                        MoonView(illumination: (smc?.moonIllumination ?? 0.1), size: 80)
                            .rotationEffect(.radians(((smc?.moonPar ?? 0)-(smc?.moonP ?? 0))))
                        Text("Angle \((smc?.moonPar ?? 0)-(smc?.moonP ?? 0))")
                    }
                    MoonView(illumination: (smc?.moonIllumination ?? 0.1), size: 80)
                        .rotationEffect(-.radians((smc?.moonPar ?? 0)-(smc?.moonP ?? 0)))
                    MoonView(illumination: (smc?.moonIllumination ?? 0.1), size: 80)
                        .rotationEffect(.radians((smc?.moonP ?? 0)-(smc?.moonPar ?? 0)))
                        .rotationEffect(.degrees(270))
                }
                
                
                MoonView(illumination: (smc?.moonIllumination ?? 0.1), size: 200)
                    .rotationEffect(.radians((smc?.moonP ?? 0)))
                    .rotationEffect(.degrees(-90))
                    
                
//                LunarOveraly(arch: 0.6).frame(width: 200, height: 200).opacity(0.85).background(Image("moon").resizable().scaledToFill().frame(width: 200, height: 200))
//                    .rotationEffect(.degrees(-90))
                
                //.clipShape(Circle())
            }
        }
//        }.onAppear() {
//            do {
//                var smcM = try SunMoonCalculator(date: customDate, longitude: long, latitude: lat)
//                smcM.calcSunAndMoon()
//                smc = smcM
//            } catch {
//                print("failded")
//            }
//        }
    }
    
    func positive(_ number: Double) -> Double {
        if number > 0 {
            return number * -1
        } else {
            return number
        }
    }
}

var customDate: Date {
    Date().adding(days: 0)
}

extension Date {
    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
}

struct MoonCardView_Previews: PreviewProvider {
    static var previews: some View {
        MoonCardView()
    }
}

struct MoonView: View {
    var illumination: Double
    var size: CGFloat
    
    var body: some View {
        ZStack {
            Image("moon").resizable().scaledToFill().frame(width: size, height: size) // Moon view
            
            if (illumination < 0.985) {
                LunarOveraly(arch: shadowArch, isArch: isArch).frame(width: size, height: size).opacity(0.85)
            }
            
        }.frame(width: size, height: size).clipShape(Circle()).rotationEffect(isArch ? .degrees(90) : .degrees(90))
    }
    
//    var rotationAngle: Angle {
//        if illumination > 0.5
//    }
    
    var isArch: Bool {
        if illumination > 0.49 {
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
        return CGFloat(3*(1-illumination))
    }
    
    // Translate illumination for illumination values < 49%
    var ellipseShadow: CGFloat {
        // 0 -> 3.14    0.25 -> ~2.7
        return CGFloat(3.14*(1-illumination))
    }
    
    var moonShadow: some View {
        Ellipse().fill(Color.black).frame(width: 100*CGFloat(illumination), height: 100*1.5)
    }
}





struct LunarOveraly: UIViewRepresentable {
    typealias UIViewType = LunarOverlayView
    var arch: CGFloat
    var isArch: Bool
    
    func makeUIView(context: UIViewRepresentableContext<LunarOveraly>) -> LunarOverlayView {
        let view = LunarOverlayView(
            frame: CGRect.zero,
            date: Date(),
            arch: self.arch,
            isArch: self.isArch
        )
        return view
    }
    
    func updateUIView(_ uiView: LunarOverlayView,
                      context: UIViewRepresentableContext<LunarOveraly>) {
        uiView.backgroundColor = UIColor.clear
    }
}

internal final class LunarOverlayView: UIView {
    private let date: Date
    private let archSize: CGFloat
    private let shadowIsArch: Bool

    init(frame: CGRect, date: Date, arch: CGFloat, isArch: Bool) {
        self.date = date
        self.archSize = arch
        self.shadowIsArch = isArch
        super.init(frame: frame)

        self.backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        self.date = Date()
        self.archSize = 0.5
        self.shadowIsArch = true
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        if shadowIsArch { // Arch shadow
            let radius = self.frame.width/2
            let angle: CGFloat = archSize // 0: none - 1.5: full

            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: -.pi, endAngle: 0, clockwise: true)
            path.addArc(withCenter: CGPoint(x: center.x, y: center.y + radius * tan(angle)), radius: radius / cos(angle), startAngle: -angle, endAngle: -.pi + angle, clockwise: false)
            
            let l = CAShapeLayer()
            l.path = path.cgPath
            layer.mask = l
            self.layer.addSublayer(l)
            
        } else { // Ellipse shadow
            let radius = self.frame.width/2
            let angle: CGFloat = archSize // 0: none - 1.5: full

            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: -.pi, endAngle: 0, clockwise: true)
            path.addArc(withCenter: CGPoint(x: center.x, y: center.y + radius * tan(angle)), radius: radius / cos(angle), startAngle: angle, endAngle: -.pi - angle, clockwise: false)
            path.stroke()
            
            let l = CAShapeLayer()
            l.path = path.cgPath
            layer.mask = l
            self.layer.addSublayer(l)
        }
    }
    
    func rad (_ value: Double) -> Double { return value * .pi / 180.0 }
}

extension View {
    func innerShadow<S: Shape>(using shape: S, angle: Angle = .degrees(0), color: Color = .black, width: CGFloat = 6, blur: CGFloat = 6) -> some View {
        let finalX = CGFloat(cos(angle.radians - .pi / 2))
        let finalY = CGFloat(sin(angle.radians - .pi / 2))
        return self
            .overlay(
                shape
                    .stroke(color, lineWidth: width)
                    .offset(x: finalX * width * 0.6, y: finalY * width * 0.6)
                    .blur(radius: blur)
                    .mask(shape)
            )
    }
}


internal final class LunarPhaseViewImpl: UIView {
    private let date: Date

    init(frame: CGRect, date: Date) {
        self.date = date
        super.init(frame: frame)

        self.backgroundColor = UIColor.clear
    }

    override init(frame: CGRect) {
        self.date = Date()
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        self.date = Date()
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        // http://www.codeproject.com/Articles/100174/Calculate-and-Draw-Moon-Phase
        let moon = SwiftySuncalc().getMoonIllumination(date: customDate)
        // 0 = full moon, 0.5 = new moon, 1.0 = full moon
        
        var smc: SunMoonCalculator? = nil
        do {
            try smc = SunMoonCalculator(date: customDate, longitude: long, latitude: lat)
            smc?.calcSunAndMoon()
        } catch {
            print("failded")
        }
        
        let phase = smc!.moonIllumination
        let diameter = Double(rect.width)
        let radius = Int(diameter / 2)

        for Ypos in 0...radius {
            let Xpos = sqrt(Double((radius * radius) - Ypos * Ypos))

            let pB1 = CGPoint(x: CGFloat(Double(radius) - Xpos), y: CGFloat(Double(Ypos) + Double(radius)))
            let pB2 = CGPoint(x: CGFloat(Double(radius) + Xpos), y: CGFloat(Double(Ypos) + Double(radius)))

            let pB3 = CGPoint(x: CGFloat(Double(radius) - Xpos), y: CGFloat(Double(radius) - Double(Ypos)))
            let pB4 = CGPoint(x: CGFloat(Double(radius) + Xpos), y: CGFloat(Double(radius) - Double(Ypos)))

            let path = UIBezierPath()
            path.move(to: pB1)
            path.addLine(to: pB2)

            path.move(to: pB3)
            path.addLine(to: pB4)

            UIColor.white.setStroke()
            path.stroke()

            let Rpos = 2 * Xpos
            var Xpos1 = 0.0
            var Xpos2 = 0.0
            
//            Xpos1 = Xpos * -1
//            Xpos2 = Double(Rpos) - (2.0 * phase * Double(Rpos)) - Double(Xpos)
            if (phase < 0.5) {
                Xpos1 = Xpos * -1
                Xpos2 = Double(Rpos) - (2.0 * phase * Double(Rpos)) - Double(Xpos)
            } else {
                Xpos1 = Xpos
                Xpos2 = Double(Xpos) - (2.0 * phase * Double(Rpos)) + Double(Rpos)
            }

            let pW1 = CGPoint(x: CGFloat(Xpos1 + Double(radius)), y: CGFloat(Double(radius) - Double(Ypos)))
            let pW2 = CGPoint(x: CGFloat(Xpos2 + Double(radius)), y: CGFloat(Double(radius) - Double(Ypos)))
            let pW3 = CGPoint(x: CGFloat(Xpos1 + Double(radius)), y: CGFloat(Double(radius) + Double(Ypos)))
            let pW4 = CGPoint(x: CGFloat(Xpos2 + Double(radius)), y: CGFloat(Double(radius) + Double(Ypos)))

            let path2 = UIBezierPath()
            path2.move(to: pW1)
            path2.addLine(to: pW2)

            path2.move(to: pW3)
            path2.addLine(to: pW4)

            UIColor.black.setStroke()
            path2.lineWidth = 2.0
            path2.stroke()
        }
    }
    
//    override func draw(_ rect: CGRect) {
//        // http://www.codeproject.com/Articles/100174/Calculate-and-Draw-Moon-Phase
//        let moon = SwiftySuncalc().getMoonIllumination(date: customDate)
//        // 0 = full moon, 0.5 = new moon, 1.0 = full moon
//
//        //let phase = (moon["fraction"]!)
//
//        var smc: SunMoonCalculator? = nil
//        do {
//            try smc = SunMoonCalculator(date: customDate, longitude: long, latitude: lat)
//            smc?.calcSunAndMoon()
//        } catch {
//            print("failded")
//        }
//
//        let phase = smc!.moonIllumination
//
//
//        let diameter = Double(rect.width)
//        let radius = Int(diameter / 2)
//
//        for Ypos in 0...radius {
//            let Xpos = sqrt(Double((radius * radius) - Ypos * Ypos))
//
//            let pB1 = CGPoint(x: CGFloat(Double(radius) - Xpos), y: CGFloat(Double(Ypos) + Double(radius)))
//            let pB2 = CGPoint(x: CGFloat(Double(radius) + Xpos), y: CGFloat(Double(Ypos) + Double(radius)))
//
//            let pB3 = CGPoint(x: CGFloat(Double(radius) - Xpos), y: CGFloat(Double(radius) - Double(Ypos)))
//            let pB4 = CGPoint(x: CGFloat(Double(radius) + Xpos), y: CGFloat(Double(radius) - Double(Ypos)))
//
//            let path = UIBezierPath()
//            path.move(to: pB1)
//            path.addLine(to: pB2)
//
//            path.move(to: pB3)
//            path.addLine(to: pB4)
//
//            UIColor.white.setStroke()
//            path.stroke()
//
//            let Rpos = 2 * Xpos
//            var Xpos1 = 0.0
//            var Xpos2 = 0.0
//            if (phase < 0.5) {
//                Xpos1 = Xpos * -1
//                Xpos2 = Double(Rpos) - (2.0 * phase * Double(Rpos)) - Double(Xpos)
//            } else {
//                Xpos1 = Xpos
//                Xpos2 = Double(Xpos) - (2.0 * phase * Double(Rpos)) + Double(Rpos)
//            }
//
//            let pW1 = CGPoint(x: CGFloat(Xpos1 + Double(radius)), y: CGFloat(Double(radius) - Double(Ypos)))
//            let pW2 = CGPoint(x: CGFloat(Xpos2 + Double(radius)), y: CGFloat(Double(radius) - Double(Ypos)))
//            let pW3 = CGPoint(x: CGFloat(Xpos1 + Double(radius)), y: CGFloat(Double(radius) + Double(Ypos)))
//            let pW4 = CGPoint(x: CGFloat(Xpos2 + Double(radius)), y: CGFloat(Double(radius) + Double(Ypos)))
//
//            let path2 = UIBezierPath()
//            path2.move(to: pW1)
//            path2.addLine(to: pW2)
//
//            path2.move(to: pW3)
//            path2.addLine(to: pW4)
//
//            UIColor.black.setStroke()
//            path2.lineWidth = 2.0
//            path2.stroke()
//        }
//    }
}
