//
//  NavigationRoutingView.swift
//  ReMU
//
//  Created by 김종수 on 1/28/26.
//

import SwiftUI

enum NavigationRoute: Equatable, Hashable {
    case home
    
}

struct NavigationRoutingView: View {
    @EnvironmentObject private var container: DIContainer
    private let route: NavigationRoute
    
    init(route: NavigationRoute) {
            self.route = route
        }
        
        var body: some View {
            Group {
                switch route {
                case .home:
                    EmptyView()
                }
            }
            .environmentObject(container)
        }
    }

