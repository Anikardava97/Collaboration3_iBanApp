//
//  AddNewPersonIbanViewModel.swift
//  Collaboration3_iBanProject
//
//  Created by Luka Gazdeliani on 12.01.24.
//

import ARKit
import Foundation
import SwiftUI
import VisionKit

enum ScanType: String {
    case text
}

enum DataScannerAccessStatusType {
    case notDetermined
    case cameraAccessNotGranted
    case cameraNotAvailable
    case scannerAvailable
    case scannerNotAvailable
}

@MainActor
final class AddNewPersonIbanViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var mockListArray: [PersonInfo] = []
    @Published var personFullName: String = ""
    @Published var ibanInfos: [IbanInfo] = [IbanInfo(bankName: "", iban: "")]
    @Published var dataScannerAccessStatus: DataScannerAccessStatusType = .notDetermined
    @Published var recognizedItems: [RecognizedItem] = []
    @Published var scanType: ScanType = .text
    @Published var textContentType: DataScannerViewController.TextContentType?
    @Published var recognisesMultipleItems = false

    
    private var isScannerAvailable: Bool {
        DataScannerViewController.isAvailable && DataScannerViewController.isSupported
    }
    
    var recognizedDataType: DataScannerViewController.RecognizedDataType {
        scanType == .text ? .text(textContentType: textContentType) : .barcode()
    }
    
    var dataScannerViewId: Int {
        var hasher = Hasher()
        hasher.combine(scanType)
        hasher.combine(recognisesMultipleItems)
        if let textContentType {
            hasher.combine(textContentType)
        }
        return hasher.finalize()
    }
    
    // MARK: - Methods
    func requestDataScannerAccessStatus() async {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            dataScannerAccessStatus = .cameraNotAvailable
            return
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
        case .authorized:
            dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
        case .restricted, .denied:
            dataScannerAccessStatus = .cameraAccessNotGranted
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            if granted {
                dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
            } else {
                dataScannerAccessStatus = .cameraAccessNotGranted
            }
            
        default: break
            
        }
    }
    
    
    // MARK: - Methods
    func changeIbanBankName(ibanInfo: IbanInfo) {
        
        guard let index = ibanInfos.firstIndex(where: { $0.id == ibanInfo.id }) else { return }
        
        ibanInfos[index].bankName = ibanInfo.bankName
    }
    
    func changeIbanIban(ibanInfo: IbanInfo) {
        
        guard let index = ibanInfos.firstIndex(where: { $0.id == ibanInfo.id }) else { return }
        
        ibanInfos[index].iban = ibanInfo.iban
    }
    
    func deleteIban(ibanInfo: IbanInfo) {
        guard let index = ibanInfos.firstIndex(where: { $0.id == ibanInfo.id }) else { return }

        if ibanInfos.count > 1 {
            ibanInfos.remove(at: index)
        }
    }
    
    func addPersonToList() {
        #warning("this data should be send back to previous page where it will be added to firebase")
        mockListArray.append(PersonInfo(fullName: personFullName, ibanInfo: ibanInfos))
    }
}
