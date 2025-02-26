/*
 See the LICENSE.txt file for this sample’s licensing information.

 Abstract:
 The restore purchases button.
 */

import SwiftUI
import StoreKit

struct RestorePurchasesButton: View {
  @State private var isRestoring = false

  var body: some View {
    Button("Restore Purchases") {
      isRestoring = true

      Task.detached {
        try? await AppStore.sync()

        // Ref: https://stackoverflow.com/a/74493943/108616
        await MainActor.run {
          isRestoring = false
        }
      }
    }
    .disabled(isRestoring)
  }

}

#Preview {
  RestorePurchasesButton()
}
