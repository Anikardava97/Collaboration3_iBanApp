//
//  DataScannerView.swift
//  Collaboration3_iBanProject
//
//  Created by Luka Gazdeliani on 12.01.24.
//

import SwiftUI
import VisionKit

struct DataScannerView: View {
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: AddNewPersonIbanViewModel
    @Binding var ibanInfo: String
    @State var isAddIBanButtonEnabled = false
    
    var coordinator: UIKitNavigationController.Coordinator
    
    // MARK: - Init
    init(coordinator: UIKitNavigationController.Coordinator, ibanInfo: Binding<String>) {
        self.coordinator = coordinator
        self._viewModel = ObservedObject(wrappedValue: AddNewPersonIbanViewModel())
        self._ibanInfo = ibanInfo
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            switch viewModel.dataScannerAccessStatus {
            case .scannerAvailable:
                mainView
            case .cameraNotAvailable:
                Text("Your Device Doesn't Have a Camera")
                
            case .scannerNotAvailable:
                Text("Your Device Doesn't Have Support For Scanning Barcode With This App")
                
            case .cameraAccessNotGranted:
                Text("Please Provide Access To The Camera In Settings")
                
            case .notDetermined:
                Text("Requesting Camera Access")
            }
        }
        .task {
            await viewModel.requestDataScannerAccessStatus()
        }
    }
    
    // MARK: - Views
    private var mainView: some View {
        VStack(spacing: 0) {
            DataScannerViewControllerRepresentable(recognizedItems: $viewModel.recognizedItems,
                                                   recognizedDataType: viewModel.recognizedDataType,
                                                   recognisesMultipleItems: viewModel.recognisesMultipleItems)
            .background(Color.gray.opacity(0.3))
            .ignoresSafeArea()
            .id(viewModel.dataScannerViewId)
            .onChange(of: viewModel.scanType) { _ in viewModel.recognizedItems = [] }
            .onChange(of: viewModel.textContentType) { _ in viewModel.recognizedItems = [] }
            .onChange(of: viewModel.recognisesMultipleItems) { _ in viewModel.recognizedItems = [] }
            
            bottomContainerView
                .foregroundStyle(.white)
                .frame(height: 200)
                .background(Color.customBackgroundColor)
        }
    }
    
    private var bottomContainerView: some View {
        VStack {
            Text("Scanning iBAN...")
                .font(.system(size: 18))
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.recognizedItems) { item in
                        switch item {
                        case .text(let text):
                            if text.transcript.count < 33 {
                                recognizedTextView(text: text)
                            }
                        case .barcode(_):
                            Text("")
                        @unknown default:
                            Text("unknown")
                        }
                    }
                }
                .padding(16)
            }
        }
        .padding(.top, 32)
    }
    
    private func recognizedTextView(text: RecognizedItem.Text) -> some View {
        VStack {
            HStack {
                Text(text.transcript)
                Spacer()
                Button {
                    let pasteboard = UIPasteboard.general
                    pasteboard.string = text.transcript
                } label: {
                    Image(systemName: "doc.on.doc.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.customAccentColor)
                    
                    Text("Copy iBAN")
                }
            }
            .padding(.horizontal, 16)
            
            Button {
                dismiss()
                ibanInfo = text.transcript
            } label: {
                PrimaryButtonComponentView(text: "Save iBAN")
            }
            .padding(.top, 16)
        }
    }
}
