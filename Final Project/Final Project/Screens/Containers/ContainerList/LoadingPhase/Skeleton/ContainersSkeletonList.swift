//
//  ContainersSkeletonList.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//



import SwiftUI

struct ContainersSkeletonList: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                ForEach(0..<7, id: \.self) { i in
                    ContainerCardSkeleton()
                        .padding(.horizontal, DS.Space.sm)
                        .opacity(1 - Double(i) * 0.12)
                }
            }
            .padding(.top, 2)
        }
    }
}
