//
//  AppInquiryViewModel.swift
//  Presentation
//
//  Created by 김정완 on 3/5/25.
//

import SwiftUI
import Domain
import Core

class AppInquiryViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var content: String = ""
    
    private var inquiryUseCase: InquiryUseCase
    
    init(inquiryUseCase: InquiryUseCase) {
        self.inquiryUseCase = inquiryUseCase
    }
    
    @MainActor
    func submitButtonTapped() async {
        do {
            let inquiry = Inquiry(title: title, comment: content)
            try await inquiryUseCase.execute(inquiry: inquiry)
        } catch {
            Logger.d(error)
        }
    }
}
