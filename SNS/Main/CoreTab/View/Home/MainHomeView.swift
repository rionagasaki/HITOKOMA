import SwiftUI

struct MainHomeView: View {

    @StateObject private var viewModel = MainHomeViewModel()
    @State var opacity: Double = 0.5
    
    var body: some View {
        VStack{
            ScrollView {
                VStack(alignment: .center){
                    TabView(selection: $viewModel.selection){
                        ForEach(viewModel.headers.indices, id: \.self) { index in
                            makeHeader(
                                headerTitle: viewModel.headers[index].headerTitle,
                                contentImage: Image(viewModel.headers[index].headerImageString)
                            ).tag(index)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width-30,height:200)
                    .redacted(reason: viewModel.isRefreshing ? .placeholder: .privacy)
                }
                .cornerRadius(15)
                .padding(.top,16)
                .onAppear{
                    viewModel.isRefreshing ? () : viewModel.startTimer()
                }.onDisappear{
                    viewModel.invalidateTimer()
                }
                Indicatorview(selection: viewModel.selection)
                HStack{
                    Text("カテゴリー")
                        .foregroundColor(.black)
                        .bold()
                        .font(.system(size: 20))
                        .padding(.leading,16)
                    Spacer()
                    Button {
                        print("aaaa")
                    } label: {
                        Text("全てを表示")
                            .font(.system(size: 13))
                            .foregroundColor(.customBlue)
                            .bold()
                            .padding(.top, 16)
                    }.padding(.trailing,20)
                }
                HStack {
                    ForEach(allCategories) { category in
                        NavigationLink {
                            switch category.category{
                            case .english: SearchCategoryDetailView(lessonsData: viewModel.lessonEnglishData, detailCategories: englishDetails, mainCategory: .english)
                            case .computer: SearchCategoryDetailView(lessonsData: viewModel.lessonComputerData, detailCategories: computerDetails, mainCategory: .computer)
                            case .law: SearchCategoryDetailView(lessonsData: viewModel.lessonLawData, detailCategories: lawDetails, mainCategory: .law)
                            case .finance: SearchCategoryDetailView(lessonsData: viewModel.lessonFinanceData, detailCategories: financeDetails, mainCategory: .finance)
                            case .investment: SearchCategoryDetailView(lessonsData: viewModel.lessonInvestmentData, detailCategories: investmentDetails, mainCategory: .investment)
                            }
                        } label: {
                            if viewModel.isRefreshing {
                                VStack{
                                    Circle()
                                        .fill(Color.customGray.opacity(opacity))
                                        .frame(width: 60)
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.customGray.opacity(opacity))
                                        .frame(width:25, height: 10)
                                }
                            } else {
                                Category(category: category)
                            }
                        }
                    }
                }
                VStack{
                    VStack(spacing: 5){
                        HStack{
                            Text("話題のひとこま")
                                .foregroundColor(.black)
                                .bold()
                                .font(.system(size: 20))
                                .padding(.leading,16)
                                .padding(.top, 16)
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                if viewModel.isRefreshing {
                                    ForEach(0 ..< 5, id: \.self) { num in
                                        VStack(spacing: .zero){
                                            Rectangle()
                                                .fill(Color.customGray.opacity(opacity))
                                                .frame(width:120, height: 90)
                                            HStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color.customGray.opacity(opacity))
                                                    .frame(width: 80, height: 10)
                                                Spacer()
                                            }.padding(.top, 5)
                                            Spacer()
                                            HStack{
                                                Circle()
                                                    .fill(Color.customGray.opacity(opacity))
                                                    .frame(width:20, height: 20)
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color.customGray.opacity(opacity))
                                                    .frame(width: 50, height: 10)
                                                Spacer()
                                            }
                                        }.frame(height: 150)
                                            .onAppear{
                                            withAnimation(.easeIn(duration: 1).repeatForever()){
                                                opacity = 0.2
                                            }
                                        }.padding(.trailing, 5)
                                    }
                                } else {
                                    ForEach(viewModel.lessonData) { lesson in
                                        NavigationLink {
                                            OneClassDetailView(lessonImageURLString: lesson.lessonImageURLString, mentorIconImageURLString: lesson.userImageIconURLString, lessonId: lesson.lessonId, mentorName: lesson.username, mentorUid: lesson.mentorUid, lessonTitle: lesson.lessonName, lessonContent: lesson.lessonContent, budgets: lesson.budget)
                                        } label: {
                                            OneClassView(lessonImageURLString: lesson.lessonImageURLString, lessonName: lesson.lessonName, userIconURLString: lesson.userImageIconURLString, lessonBudgets: lesson.budget)
                                        }
                                    }
                                }
                            }
                        }.padding(.horizontal, 16)
                    }
                    lessonList(bigCategory: "英語", categoryLessonData: viewModel.lessonEnglishData, deatilCategories: englishDetails, categoryDetail: .english)
                    lessonList(bigCategory: "IT", categoryLessonData: viewModel.lessonComputerData, deatilCategories: computerDetails, categoryDetail: .computer)
                    lessonList(bigCategory: "法律", categoryLessonData: viewModel.lessonLawData, deatilCategories: lawDetails, categoryDetail: .law)
                    lessonList(bigCategory: "ファイナンス", categoryLessonData: viewModel.lessonFinanceData, deatilCategories: financeDetails, categoryDetail: .finance)
                    lessonList(bigCategory: "投資", categoryLessonData: viewModel.lessonInvestmentData, deatilCategories: investmentDetails, categoryDetail: .investment)
                }
            }
        }.allowsHitTesting(!viewModel.isRefreshing)
    }
    
    private func makeHeader(headerTitle: String, contentImage: Image) -> some View{
        return contentImage.resizable().frame(width: UIScreen.main.bounds.width-30,height:200).scaledToFill().modifier(headerImageModifier(headerTitle: headerTitle))
    }
    
    private func lessonList(bigCategory: String, categoryLessonData: [LessonData], deatilCategories:[DetailCategory], categoryDetail: CategoryDetail) -> some View {
        VStack(spacing: 5){
            NavigationLink {
                SearchCategoryDetailView(lessonsData: categoryLessonData, detailCategories: deatilCategories, mainCategory: categoryDetail)
            } label: {
                HStack{
                    Text(bigCategory)
                        .foregroundColor(.black)
                        .bold()
                        .font(.system(size: 18))
                        .padding(.leading,16)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width:10, height:13)
                        .foregroundColor(.gray)
                        .font(.largeTitle.weight(.bold))
                    Spacer()
                }
            }
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(categoryLessonData) { lesson in
                        NavigationLink {
                            OneClassDetailView(lessonImageURLString: lesson.lessonImageURLString, mentorIconImageURLString: lesson.userImageIconURLString, lessonId: lesson.lessonId, mentorName: lesson.username, mentorUid: lesson.mentorUid, lessonTitle: lesson.lessonName, lessonContent: lesson.lessonContent, budgets: lesson.budget)
                        } label: {
                            OneClassView(lessonImageURLString: lesson.lessonImageURLString, lessonName: lesson.lessonName, userIconURLString: lesson.userImageIconURLString, lessonBudgets: lesson.budget)
                        }
                    }
                }
            }.padding(.horizontal, 16)
        }.padding(.top,16)
    }
}


struct MainHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomeView()
    }
}


