//
//  ViewExtension.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/26.
//

import SwiftUI

extension View {
    func halfModal<Sheet: View>(
        isShow: Binding<Bool>,
        @ViewBuilder sheet: @escaping () -> Sheet
    ) -> some View {
        return self.background(
            
        )
    }
    
    func pageLabel()-> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
}

struct HalfModalSheetViewController<Sheet: View>: UIViewControllerRepresentable {
  var sheet: Sheet
  @Binding var isShow: Bool
  var onClose: () -> Void
  
  func makeUIViewController(context: Context) -> UIViewController {
    UIViewController()
  }
  
  func updateUIViewController(
    _ viewController: UIViewController,
    context: Context
  ) {
      if isShow {
          let sheetController = CustomHostingController(rootView: sheet)
          sheetController.presentationController!.delegate = context.coordinator
          viewController.present(sheetController, animated: true)
      } else {
          viewController.dismiss(animated: true) { onClose() }
      }
  }
  func makeCoordinator() -> Coordinator {
    Coordinator(parent: self)
  }
  
  class Coordinator: NSObject, UISheetPresentationControllerDelegate {
    var parent: HalfModalSheetViewController

    init(parent: HalfModalSheetViewController) {
      self.parent = parent
    }

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
      parent.isShow = false
    }
  }
  
  class CustomHostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
      super.viewDidLoad()
      if let sheet = self.sheetPresentationController {
        sheet.detents = [.medium(),]
        sheet.prefersGrabberVisible = true
      }
    }
  }
}
