//
//  SettingSendView.swift
//  Presentation
//
//  Created by 김정완 on 3/5/25.
//

import SwiftUI
import Domain

struct AppInquiryView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: AppInquiryViewModel
    
    init(inquiryUseCase: InquiryUseCase) {
        _viewModel = StateObject(wrappedValue: AppInquiryViewModel(inquiryUseCase: inquiryUseCase))
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // 제목 입력 필드
            VStack(alignment: .leading) {
                Text("문의 제목")
                    .font(.headline)
                
                TextField("제목을 입력하세요", text: $viewModel.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle()) // 기본 스타일 적용
                
            }
            .padding(.horizontal)
            
            // 내용 입력 필드
            VStack(alignment: .leading) {
                Text("문의 내용")
                    .font(.headline)
                
                ZStack {
                    // 배경 + 둥근 테두리 적용
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(UIColor.separator), lineWidth: 1) // 테두리 추가
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(UIColor.systemBackground))) // 배경색 적용
                        .clipShape(RoundedRectangle(cornerRadius: 8)) // 클리핑 적용
                    
                    TextEditor(text: $viewModel.content)
                        .padding(8) // 내부 여백 조정
                        .background(Color.clear) // 배경을 투명하게
                }
                .frame(minHeight: 180) // 높이 유지
            }
            .padding(.horizontal)
            
            // 보내기 버튼
            Button(action: {
                Task {
                    await viewModel.submitButtonTapped()
                    DispatchQueue.main.async {
                        dismiss()
                    }
                }
            }) {
                Text("보내기")
                    .frame(maxWidth: .infinity) // 가득 차게
                    .frame(height: 44) // 높이 조정
                    .background(Color.blue) // 배경색 적용
                    .foregroundColor(.white) // 글자색 적용
                    .font(.headline) // 텍스트 크기 조정
                    .cornerRadius(8) // 둥근 모서리
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.top, 16)
        .background(Color(UIColor.systemBackground)) // 다크 테마 고려한 배경 적용
        .navigationTitle("앱 문의하기")
    }
}
