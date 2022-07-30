import SwiftUI
import XCLog

/// 刚打开app时看到界面
struct MainView: View {
    var body: some View {
        // 不一定要使用NavigationView
        NavigationView {
            ProjectsView()
                .navigationTitle("Projects")
        }
        .navigationViewStyle(.stack)
    }
}

/// 呈现用户所有的项目的界面
///
/// TODO 之后可以做成格子状的 列表有些单一 可以支持排序
///
/// 可以加上项目的创建/修改时间、时长、大小等参数
struct ProjectsView: View {
    @State var isPresentingProjectView = false

    var body: some View {
        List {
            ForEach([0, 1, 2], id: \.self) { project_id in
                Button { // use a Button instead of a Text to make the whole row tappable
                    XCLog("tapped")
                    isPresentingProjectView.toggle()
                } label: {
                    Text("Project \(project_id)")
                        .foregroundColor(.black)
                }
                .fullScreenCover(isPresented: $isPresentingProjectView) {
                    ProjectView(isPresentingProjectView: $isPresentingProjectView,
                                project_id: project_id)
                }
            }
        }
    }
}

/// 一个项目的界面
///
/// 会全屏显示出来 左侧为文件列表 右侧为文件内容
struct ProjectView: View {
    @Binding var isPresentingProjectView: Bool

    var project_id: Int

    var body: some View {
        NavigationView {
            // FIXME: 上方的空隙好像有点多啊
            List {
                ForEach([0, 1, 2, 3], id: \.self) { file_id in
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
            .navigationTitle("Project \(project_id)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // 项目标题右侧 关闭当前项目
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        XCLog("clicked")
                        isPresentingProjectView.toggle()
                    } label: {
                        Image(systemName: "multiply")
                    }
                }
            }

            FileView.NoFileSelectedView()
        }
        .navigationViewStyle(.columns)
    }

    struct NoProjectSelectedView: View {
        var body: some View {
            Text("Please select a project.")
        }
    }
}

/// 文件内容页面
struct FileView: View {
    var project_id: Int
    var file_id: Int

    var body: some View {
        Text("Project \(project_id) - File \(file_id)")
    }

    struct NoFileSelectedView: View {
        var body: some View {
            Text("Please select a file.")
        }
    }
}
