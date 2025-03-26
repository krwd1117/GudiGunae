//
//  AppInquiryViewModel.swift
//  Presentation
//
//  Created by 김정완 on 3/5/25.
//

import SwiftUI

import Core
import DI
import Domain


class AppInquiryViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var content: String = ""
    
    private var inquiryUseCase: InquiryUseCase
    
    init(inquiryUseCase: InquiryUseCase? = nil) {
        self.inquiryUseCase = inquiryUseCase ?? DIContainer.shared.resolve(InquiryUseCase.self)
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
