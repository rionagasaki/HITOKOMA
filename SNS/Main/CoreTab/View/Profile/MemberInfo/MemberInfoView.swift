//
//  MemberInfoView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/15.
//

import SwiftUI
import FirebaseFirestore
import SDWebImageSwiftUI

struct MemberInfoView: View {
    @StateObject private var viewModel = MemberInfoViewModel()
    @EnvironmentObject var user: User
    @FocusState var isClosed:Bool
    @State private var selection: Int = 0
    @State private var location: Double = 0
    
    let color1 = Color(red: 67/255, green: 92/255, blue: 130/255)
    let color2 = Color(red: 71/255, green: 117/255, blue: 132/255)
    
    var body: some View {
        ScrollView {
            VStack(spacing: .zero){
                SettingprofileViewHeader(user: user, viewModel: viewModel)
                SelectGenderView(genderField: $viewModel.genderField)
                    .padding(.top, 8)
                ZStack(alignment: .topLeading){
                    TextEditor(text: $viewModel.introduceField)
                        .padding(.leading, 8)
                        .frame(width: UIScreen.main.bounds.width-32, height:150)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2))
                        .padding(.bottom, 8)
                    
                    Text("一言プロフィール")
                        .font(.system(size: 15))
                        .padding(.leading, 12)
                        .padding(.top, 8)
                        .foregroundColor(.customGray)
                        .opacity(0.6)
                }
                .padding(.horizontal, 16)
                Divider()
                
                SettingCarrerView(careerField: $viewModel.careerField)
                Text("スキル")
                    .font(.system(size: 18))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 8)
                    .padding(.leading, 16)
                SettingSkillView(
                    skillField: $viewModel.skillField,
                    location: $location)
                
                Button {
                    print("aaa")
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .background(Color.customBlue)
                        .clipShape(Circle())
                        .padding(.top, 24)
                }
                Spacer()
            }
        }
        .navigationTitle("プロフィール編集")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing){
                Button {
                    print("aaa")
                } label: {
                    VStack {
                        Image(systemName: "arrow.clockwise")
                        Text("更新する")
                            .fontWeight(.light)
                            .font(.system(size:10))
                            .foregroundColor(.black.opacity(0.8))
                    }
                }
            }
        })
    }
}

struct MemberInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MemberInfoView()
    }
}

struct SettingprofileViewHeader: View {
    let user: User
    @StateObject var viewModel: MemberInfoViewModel
    var body: some View {
        VStack {
            Image(image.others.ramen.name)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 150)
                .overlay(
                    Button(action: {
                        print("aaa")
                    }, label: {
                        ZStack {
                            Color.black.opacity(0.5)
                            Image(systemName: "camera.fill")
                                .resizable()
                                .frame(width: 60, height: 50)
                                .scaledToFit()
                                .foregroundColor(.white)
                        }
                    })
                )
            HStack{
                Button {
                    print("aa")
                } label: {
                    ZStack(alignment: .bottomTrailing){
                        WebImage(url: URL(string: user.profileImage))
                            .resizable()
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                            .background(Circle().stroke(.white, lineWidth: 5))
                            .padding(.leading, 16)
                            .padding(.top, -35)
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width:30, height:30)
                            .clipShape(Circle())
                            .foregroundColor(.customBlue)
                            .background(Circle().stroke(.white, lineWidth: 3))
                            .background(Color.white.clipShape(Circle()))
                            .padding(.top, -8)
                            .padding(.leading, -8)
                    }
                }
                Spacer()
            }
            Divider()
            TextField(user.username, text: $viewModel.usernameField, prompt: Text("ユーザーネーム"))
                .padding(.leading, 10)
                .frame(height: 38)
                .overlay(RoundedRectangle(cornerRadius: 3)
                    .stroke(Color.customLightGray, lineWidth: 2))
                .padding(.horizontal, 16)
                .padding(.top, 5)
            
            TextField("aaaa", text: $viewModel.ageField, prompt: Text("年齢"))
                .padding(.leading, 10)
                .frame(height: 38)
                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2))
                .padding(.horizontal, 16)
                .padding(.top, 5)
        }
    }
}

struct SelectGenderView: View {
    @Binding var genderField: Gender
    var body: some View {
        VStack {
            HStack(alignment: .center){
                Button {
                    genderField = .man
                } label: {
                    VStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                            .foregroundColor(genderField == .man ? .blue: .customLightGray)
                        Text("男性")
                            .fontWeight(.medium)
                            .font(.system(size: 12))
                            .foregroundColor(genderField == .man ? .customGray: .customLightGray)
                    }
                }.padding(.leading, 32)
                Spacer()
                Button {
                    genderField = .woman
                } label: {
                    VStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                            .foregroundColor(genderField == .woman ? .customRed2: .customLightGray)
                        Text("女性")
                            .fontWeight(.medium)
                            .font(.system(size: 12))
                            .foregroundColor(genderField == .woman ? .customGray: .customLightGray)
                    }
                }
                Spacer()
                Button {
                    genderField = .others
                } label: {
                    VStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                            .foregroundColor(genderField == .others ? .yellow: .customLightGray)
                        Text("その他")
                            .fontWeight(.medium)
                            .font(.system(size: 12))
                            .foregroundColor(genderField == .others ? .customGray: .customLightGray)
                    }
                }.padding(.trailing, 32)
            }
            .padding(.top, 8)
            .padding(.bottom, 8)
        }
    }
}

struct SettingCarrerView: View {
    
    @Binding var careerField: String
    
    var body: some View {
        VStack(spacing: .zero){
            Text("経歴")
                .font(.system(size: 18))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .padding(.vertical, 8)
            
            ZStack(alignment: .topLeading){
                TextEditor(text: _careerField.projectedValue)
                    .padding(.leading, 8)
                    .frame(width: UIScreen.main.bounds.width-32, height:150)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2))
                    .padding(.bottom, 8)
                Text("経歴を入力してください。")
                    .foregroundColor(.customGray)
                    .opacity(0.6)
                    .padding(.top, 8)
                    .padding(.leading, 12)
            }
        }
    }
}

struct SettingSkillView: View {
    @Binding var skillField: String
    @State var experimentYears: Double = 3.0
    @Binding var location: Double
    var body: some View {
        VStack {
            TextField("", text: $skillField, prompt: Text("スキル名"))
                .padding(.leading, 10)
                .frame(height: 38)
                .overlay(RoundedRectangle(cornerRadius: 3)
                    .stroke(Color.customLightGray, lineWidth: 2))
                .padding(.horizontal, 16)
                .padding(.top, 5)
            HStack {
                Text("経験年数\(location > 20 ? "３年":"1年")")
                    .fontWeight(.light)
                    .font(.system(size: 15))
                    .foregroundColor(.black.opacity(0.8))
                    .padding(.leading, 16)
                Spacer()
                SliderView3(
                    value: $experimentYears,
                    location: $location)
                    .frame(width: 200)
                    .padding(.trailing, 16)
            }
        }
        .padding(.bottom, 8)
    }
}

struct GenderMenu {
    let gender: Gender
    let genderColor: Color
}

struct SliderView3: View {
    @Binding var value: Double
    @State var lastCoordinateValue: CGFloat = 0.0
    var sliderRange: ClosedRange<Double> = 1...100
    @Binding var location: Double
    
    var body: some View {
        GeometryReader { gr in
            let thumbSize = gr.size.height * 1.2
            let radius = gr.size.height
            let minValue = gr.size.width * 0.015
            let maxValue = gr.size.width
            
            let scaleFactor = (maxValue - minValue) / (sliderRange.upperBound - sliderRange.lowerBound)
            let lower = sliderRange.lowerBound
            let sliderVal = (self.value - lower) * scaleFactor + minValue
            
            ZStack {
                Rectangle()
                    .foregroundColor(.customLightGray)
                    .frame(width: gr.size.width, height: gr.size.height * 0.95)
                    .clipShape(RoundedRectangle(cornerRadius: radius))
                HStack {
                    Rectangle()
                        .foregroundColor(.customBlue)
                        .frame(width: sliderVal, height: gr.size.height * 0.95)
                    Spacer()
                }
                .clipShape(RoundedRectangle(cornerRadius: radius))
                
                HStack {
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(.customGray)
                        .frame(width: thumbSize, height: thumbSize)
                        .offset(x: sliderVal - 10)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { v in
                                    location = v.location.x
                                    if (abs(v.translation.width) < 0.1) {
                                        self.lastCoordinateValue = sliderVal
                                    }
                                    if v.translation.width > 0 {
                                        let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + v.translation.width)
                                        self.value = ((nextCoordinateValue - minValue) / scaleFactor)  + lower
                                    } else {
                                        let nextCoordinateValue = max(minValue, self.lastCoordinateValue + v.translation.width)
                                        self.value = ((nextCoordinateValue - minValue) / scaleFactor) + lower
                                    }
                               }
                        )
                    Spacer()
                }
            }
        }
    }
}
