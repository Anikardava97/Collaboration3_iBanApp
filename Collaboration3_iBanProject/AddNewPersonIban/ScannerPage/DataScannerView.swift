//
//  DataScannerView.swift
//  Collaboration3_iBanProject
//
//  Created by Luka Gazdeliani on 12.01.24.
//

import SwiftUI
import VisionKit

struct DataScannerView: View {
    //MARK: - Properties
    @ObservedObject var viewModel: AddNewPersonIbanViewModel
    var coordinator: UIKitNavigationController.Coordinator
    
    init(coordinator: UIKitNavigationController.Coordinator) {
        self.coordinator = coordinator
        self._viewModel = ObservedObject(wrappedValue: AddNewPersonIbanViewModel())
    }
    
    //MARK: - Body
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
    
    //MARK: - Content
    private var mainView: some View {
        VStack {
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
                .frame(height: 300)
        }
    }
    
    private var headerView: some View {
        VStack {
            Picker("Scan Type", selection: $viewModel.scanType) {
                Text("Scan iBAN").tag(ScanType.text)
            }.pickerStyle(.segmented)
            
            if viewModel.scanType == .text {
                Picker("Text content type", selection: $viewModel.textContentType) {
                    Text(viewModel.headerText).padding(.top)
                }
                .pickerStyle(.segmented)
            }
        }
        .padding(.horizontal)
    }
    
    private var bottomContainerView: some View {
        
        VStack {
            
            headerView
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10){
                    ForEach(viewModel.recognizedItems) { item in
                        switch item {
                        case .text(let text):
                            if text.transcript.count == 22 {
                                if text.transcript.prefix(2) == "GE" {
                                    Button {
                                        let pasteboard = UIPasteboard.general
                                        pasteboard.string = text.transcript
                                    } label: {
                                        Image(systemName: "doc.on.doc.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(Color.blue)
                                        
                                        Text("Copy iBAN")
                                    }
                                    .padding(.leading, 8)
                                    
                                    Text(text.transcript)
                                }
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
}
