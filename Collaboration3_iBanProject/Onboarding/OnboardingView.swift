//
//  OnboardingView.swift
//  Collaboration3_iBanProject
//
//  Created by Ani's Mac on 10.01.24.
//

import SwiftUI

struct OnboardingView: View {
    //MARK: - Properties
    @State private var onboardingViewed = UserDefaults.standard.bool(forKey: "onboarding_viewed")
    @State private var pageIndex = 0
    
    private let pages: [Page] = Page.onboardPages
    
    var coordinator: UIKitNavigationController.Coordinator

    // MARK: - Init
    init(coordinator: UIKitNavigationController.Coordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: - Body
    var body: some View {
        if onboardingViewed {
            LoginView(coordinator: coordinator)
        } else {
            onboarding
        }
    }
}

//MARK: - Content
extension OnboardingView {
    //Pages View
    private var onboarding: some View {
        TabView(selection: $pageIndex) {
            tabPages
        }
        .animation(.easeInOut, value: pageIndex)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .background(Color.customBackgroundColor).ignoresSafeArea()
    }
    
    private var tabPages: some View {
        ForEach(pages) { page in
            VStack {
                skipButton
                PageView(page: page)
                Spacer()
                if page == pages.last {
                    getStartedButton
                } else {
                    nextButton
                }
                Spacer(minLength: 50)
            }
            .tag(page.tag)
        }
    }
    
    //Functions
    private func incrementPage() {
        pageIndex += 1
    }
    
    private func goToZero() {
        pageIndex = 0
    }
    
    //Buttons
    private var skipButton: some View {
        HStack{
            Spacer()
            Button(action: {
                UserDefaults.standard.set(false, forKey: "onboarding_viewed")
                coordinator.navigate(to: .loginPage)
            }) {
                Text("Skip")
                    .foregroundColor(.gray)
                    .underline()
            }
            .padding()
        }
    }
    
    private var nextButton: some View {
        OnboardingButton(action: incrementPage, actionText: "Next")
    }
    
    private var getStartedButton: some View {
        OnboardingButton(action: {
            UserDefaults.standard.set(true, forKey: "onboarding_viewed")
            coordinator.navigate(to: .loginPage)
        }, actionText: "Get Started")
    }
}

//MARK: - Preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(coordinator: UIKitNavigationController.Coordinator())
            .background(Color.customBackgroundColor)
    }
}
