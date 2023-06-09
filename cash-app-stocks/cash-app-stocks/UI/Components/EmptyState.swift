//
//  EmptyState.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/8/23.
//

import SwiftUI

struct EmptyState: View {
    let retryAction: () -> Void
    var body: some View {
        VStack {
            Text("No stocks available")
                .font(.title)
                .padding(.bottom, 40).padding()
            Button(action: retryAction, label: {
                Text("Retry").bold()
            })
        }
    }
}

struct EmptyState_Previews: PreviewProvider {
    static var previews: some View {
        EmptyState(retryAction: { })
    }
}
