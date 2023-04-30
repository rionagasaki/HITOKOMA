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
    @StateObject var viewModel = MemberInfoViewModel()
    @Environment(\.dismiss) var dismiss
    @FocusState var isClosed:Bool
    @Namespace var nameSpace
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: .zero) {
                SettingprofileViewHeader(viewModel: viewModel)
                SelectGenderView(viewModel: viewModel, id: nameSpace)
                    .padding(.top, 8)
                
                ProfileMessageView(viewModel: viewModel)
                AddSkillsView(viewModel: viewModel)
                SettingCarrerView(viewModel: viewModel)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("プロフィール編集")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $viewModel.settingImage) { image in
            switch image {
            case .headerImage:
                ImagePicker(
                    sourceType: .photoLibrary,
                    selectedImage: $viewModel.headerImage
                )
            case .profileImage:
                ImagePicker(
                    sourceType: .photoLibrary,
                    selectedImage: $viewModel.profileImage
                )
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing){
                Button {
                    viewModel.updateProfile()
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
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .heavy))
                        .foregroundColor(.customGray)
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
    @StateObject var viewModel: MemberInfoViewModel
    
    private func HeaderImageView(headerImage: UIImage?) -> some View {
        Group {
            if let headerImage = headerImage {
                Image(uiImage: headerImage)
                    .resizable()
            } else {
                if User.shared.headerImage == "" {
                    Image(image.others.noHeaderImage)
                        .resizable()
                } else {
                    WebImage(url: URL(string: User.shared.headerImage))
                        .resizable()
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            HeaderImageView(headerImage: viewModel.headerImage)
                .frame(width: UIScreen.main.bounds.width, height: 150)
                .overlay(
                    Button(action: {
                        viewModel.settingImage = .headerImage
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
                    viewModel.settingImage = .profileImage
                } label: {
                    ZStack(alignment: .bottomTrailing){
                        if let profileImage = viewModel.profileImage {
                            Image(uiImage: profileImage)
                                .resizable()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .background(Circle().stroke(.white, lineWidth: 5))
                                .padding(.leading, 16)
                                .padding(.top, -35)
                        } else {
                            WebImage(url: URL(string: viewModel.currentProfileImageURLString))
                                .resizable()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .background(Circle().stroke(.white, lineWidth: 5))
                                .padding(.leading, 16)
                                .padding(.top, -35)
                        }
                        
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
            CustomDividerWidthText(text: "ユーザーネーム")
                .padding(.vertical, 16)
            TextField("", text: $viewModel.usernameField, prompt: Text("ユーザーネーム"))
                .padding(.leading, 8)
                .frame(height: 38)
                .overlay(RoundedRectangle(cornerRadius: 3)
                    .stroke(Color.customLightGray, lineWidth: 2))
                .padding(.horizontal, 16)
                .onAppear{
                    viewModel.usernameField = User.shared.username
                }
            CustomDividerWidthText(text: "年齢")
                .padding(.vertical, 16)
            Menu {
                ForEach(viewModel.generations
                        , id: \.self) { generation in
                    Button {
                        if generation != "未選択" {
                            viewModel.ageField = generation
                        } else {
                            viewModel.ageField = ""
                        }
                    } label: {
                        Text(generation)
                    }
                }
            } label: {
                Text(viewModel.ageField == "" ? "未選択": viewModel.ageField)
                    .foregroundColor(viewModel.ageField == "" || viewModel.ageField == "未選択" ? .gray: .black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
            }
            .frame(width: UIScreen.main.bounds.width-32)
        }
    }
}

struct SelectGenderView: View {
    @StateObject var viewModel: MemberInfoViewModel
    let id:Namespace.ID
    
    var body: some View {
        VStack {
            CustomDividerWidthText(text:"性別", requiered: false)
                .padding(.vertical, 16)
            HStack(alignment: .center){
                ForEach(viewModel.genders, id: \.self) { gender in
                    
                    ZStack {
                        if viewModel.genderField == gender {
                            Circle()
                                .fill(Color.customBlue.opacity(0.2))
                                .frame(width: 70)
                                .matchedGeometryEffect(id: "Gender", in: id)
                        }
                        Button {
                            withAnimation {
                                viewModel.genderField = gender
                            }
                        } label: {
                            VStack {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .scaledToFit()
                                    .foregroundColor(viewModel.genderField == gender ? gender.color : .customLightGray)
                                
                                Text(gender.gender.rawValue)
                                    .fontWeight(.medium)
                                    .font(.system(size: 13))
                                    .foregroundColor(viewModel.genderField == gender ? .customGray: .customLightGray)
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 16)
        }
    }
}

struct SettingCarrerView: View {
    
    @StateObject var viewModel: MemberInfoViewModel
    
    var body: some View {
        VStack(spacing: .zero){
            CustomDividerWidthText(text: "経歴")
                .padding(.vertical, 16)
            
            ZStack(alignment: .topLeading){
                TextEditor(text: _viewModel.projectedValue.careerField)
                    .padding(.leading, 8)
                    .frame(width: UIScreen.main.bounds.width-32, height:150)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2))
                
                if !viewModel.isEditCareerField {
                    Text("経歴を入力してください。")
                        .foregroundColor(.customGray)
                        .opacity(0.6)
                        .padding(.top, 8)
                        .padding(.leading, 12)
                }
            }
        }
    }
}

struct SettingSkillView: View {
    @StateObject var viewModel: MemberInfoViewModel
    let index: Int
    var body: some View {
        VStack {
            TextField("", text: $viewModel.skills[index].skillName, prompt: Text("スキル名"))
                .padding(.leading, 10)
                .frame(height: 38)
                .overlay(RoundedRectangle(cornerRadius: 3)
                    .stroke(Color.customLightGray, lineWidth: 2))
                .padding(.horizontal, 16)
                .padding(.top, 5)
                
            HStack {
                Text("経験年数\(viewModel.skills[index].skillYearText)")
                    .fontWeight(.light)
                    .font(.system(size: 15))
                    .foregroundColor(.black.opacity(0.8))
                    .padding(.leading, 16)
                Spacer()
                SliderView3(
                    value: $viewModel.skills[index].skillYear,
                    location: $viewModel.skills[index].skillYear)
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
    @Binding var location: Double
    @State var lastCoordinateValue: CGFloat = 0.0
    var sliderRange: ClosedRange<Double> = 1...100
    
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

enum SettingImage: String ,CaseIterable, Identifiable {
    var id: String { rawValue }
    case headerImage
    case profileImage
}

struct Skills: Codable {
    var skills: [Skill]
}

struct Skill: Identifiable, Codable {
    let id = UUID()
    var skillName: String
    var skillYear: Double
    var skillYearText: String {
        if skillYear < 20 {
            return "3ヶ月以下"
        } else if 20 <= skillYear && skillYear < 40 {
            return "3ヶ月~半年"
        } else if 40 <= skillYear && skillYear < 60 {
            return "半年~１年"
        } else if 60 <= skillYear && skillYear < 80 {
            return "1年~１年半"
        } else if 80 <= skillYear && skillYear < 100 {
            return "１年半~2年"
        } else if 100 <= skillYear && skillYear < 120 {
            return "2年~2年半"
        } else if 120 <= skillYear && skillYear < 140 {
            return "2年半~3年"
        }
        return ""
    }
    
    enum CodingKeys: String, CodingKey {
        case skillName = "skill_name"
        case skillYear = "skill_year"
    }
}

struct ProfileMessageView: View {
    
    @StateObject var viewModel: MemberInfoViewModel
    
    var body: some View {
        VStack {
            CustomDividerWidthText(text: "メッセージ")
                .padding(.vertical, 16)
            ZStack(alignment: .topLeading){
                TextEditor(text: $viewModel.introduceField)
                    .padding(.leading, 8)
                    .frame(width: UIScreen.main.bounds.width-32, height:150)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2))
                    .padding(.bottom, 8)
                
                if !viewModel.isEditIntroduceField {
                    Text("一言プロフィール")
                        .foregroundColor(.customGray)
                        .opacity(0.6)
                        .padding(.top, 8)
                        .padding(.leading, 12)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct AddSkillsView: View {
    
    @StateObject var viewModel: MemberInfoViewModel
    
    var body: some View {
        VStack {
            CustomDividerWidthText(text: "スキル")
                .padding(.vertical,16)
            
            ForEach(viewModel.skills.indices, id: \.self) { index in
                SettingSkillView(viewModel: viewModel, index: index)
            }
            
            Button {
                withAnimation {
                    viewModel.skills.append(Skill(skillName: "", skillYear: 0.0))
                }
            } label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .background(Color.customBlue)
                    .clipShape(Circle())
            }
            .id(1)
        }
    }
}
