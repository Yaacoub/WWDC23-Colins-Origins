import SwiftUI

struct LearnMore: View {
    
    
    
    // MARK: - Properties
    
    let sections: [MarkdownSection]
    
    @Environment(\.dismiss) var dismiss
    
    
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                Color.yellow.opacity(0.25).edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(sections, id: \.id) { section in
                            Text(section.title)
                                .font(.custom("16x8Pxl_Mono", size: 40, relativeTo: .title))
                                .padding([.vertical])
                            Text(section.body)
                                .font(.body)
                            if let image = section.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .padding([.vertical])
                            }
                        }
                    }
                    .padding([.bottom, .horizontal])
                }
                .navigationTitle("")
            }
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .tint(.black)
                }
            }
        }.navigationViewStyle(.stack)
    }
    
}
