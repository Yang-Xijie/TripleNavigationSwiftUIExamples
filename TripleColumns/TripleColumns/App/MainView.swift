import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ProjectsSidebar()
                .navigationTitle("Projects")
                .navigationBarTitleDisplayMode(.inline)

            FilesSidebar.DefaultView()

            FileView.DefaultView()
        }
        .navigationViewStyle(.columns)
    }
}

struct ProjectsSidebar: View {
    var body: some View {
        List {
            ForEach([1, 2, 3], id: \.self) { project_id in
                NavigationLink {
                    FilesSidebar(project_id: project_id)
                        .navigationTitle("Project \(project_id)")
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Text("Project \(project_id)")
                }
            }
        }
        .listStyle(.sidebar)
    }
}

struct FilesSidebar: View {
    var project_id: Int

    var body: some View {
        List {
            ForEach([1, 2, 3, 4], id: \.self) { file_id in
                NavigationLink {
                    FileView(project_id: project_id, file_id: file_id)
                        .navigationTitle("File")
                        .navigationBarTitleDisplayMode(.inline)

                } label: {
                    Text("File \(file_id)")
                }
            }
        }
        .listStyle(.sidebar)
    }

    struct DefaultView: View {
        var body: some View {
            Text("Please select a project.")
        }
    }
}

struct FileView: View {
    var project_id: Int
    var file_id: Int

    var body: some View {
        Text("Project \(project_id) - File \(file_id)")
    }

    struct DefaultView: View {
        var body: some View {
            Text("Please select a file.")
        }
    }
}
