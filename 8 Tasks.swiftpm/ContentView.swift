import SwiftUI

struct Task: Identifiable, Hashable {
    let id: UUID = UUID()
    var title: String = ""
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct TheState {
    var tasks: [Task] = [Task(title: "A task")]
}

struct ContentView: View {
    @State var state: TheState = TheState()
    @FocusState private var focusedTask: Task?
    var body: some View {
        VStack {
            List($state.tasks, editActions: .all) { $task in
                TextField("", text: $task.title,
                          prompt: Text("Enter your task title")
                                      .foregroundStyle(.gray)
                                      .italic())
                    .onSubmit {
                        newTask(after: task)
                    }
                    .focused($focusedTask, equals: task)
            }
            Button("Add Task") {
                newTask()
            }
        }
    }
    
    private func newTask(after task: Task? = nil) {
        let newTask = Task()
        let index = task.map { t in state.tasks.firstIndex { $0.id == t.id}! }
        ?? state.tasks.count - 1
        state.tasks.insert(newTask, at: index + 1)
        focusedTask = newTask
    }
}
