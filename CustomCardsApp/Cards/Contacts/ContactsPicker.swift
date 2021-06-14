//
//  ContactsPicker'.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-10.
//

import SwiftUI
import ContactsUI

/** Allow user to access & choose contact */
public struct ContactPicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var showPicker: Bool
    @State private var viewModel = ContactPickerViewModel()
    public var onSelectContact: ((_: CNContact) -> Void)?
    public var onCancel: (() -> Void)?
    
    public init(showPicker: Binding<Bool>, onSelectContact: ((_: CNContact) -> Void)? = nil, onCancel: (() -> Void)? = nil) {
        self._showPicker = showPicker
        self.onSelectContact = onSelectContact
        self.onCancel = onCancel
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<ContactPicker>) -> ContactPicker.UIViewControllerType {
        let dummy = _DummyViewController()
        viewModel.dummy = dummy
        return dummy
    }
    
    public func updateUIViewController(_ uiViewController: _DummyViewController, context: UIViewControllerRepresentableContext<ContactPicker>) {

        guard viewModel.dummy != nil else {
            return
        }
        
        // able to present when
        // 1. no current presented view
        // 2. current presented view is being dismissed
        let ableToPresent = viewModel.dummy.presentedViewController == nil || viewModel.dummy.presentedViewController?.isBeingDismissed == true
        
        // able to dismiss when
        // 1. cncpvc is presented
        let ableToDismiss = viewModel.vc != nil
        
        if showPicker && viewModel.vc == nil && ableToPresent {
            let pickerVC = CNContactPickerViewController()
            pickerVC.delegate = context.coordinator
            viewModel.vc = pickerVC
            viewModel.dummy.present(pickerVC, animated: true)
            
        } else if !showPicker && ableToDismiss {
            self.viewModel.vc = nil
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        return SingleSelectionCoordinator(self)
    }
    
    public final class SingleSelectionCoordinator: NSObject, Coordinator {
        var parent : ContactPicker
        
        init(_ parent: ContactPicker) {
            self.parent = parent
        }
        
        public func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            parent.showPicker = false
            parent.onCancel?()
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        public func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            parent.showPicker = false
            parent.onSelectContact?(contact)
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

class ContactPickerViewModel {
    var dummy: _DummyViewController!
    var vc: CNContactPickerViewController?
}

public protocol Coordinator: CNContactPickerDelegate {}

public class _DummyViewController: UIViewController {}
