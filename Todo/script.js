document.getElementById('todo-form').addEventListener('submit', function(e) {
    e.preventDefault();
    
    this.submit();
});

document.getElementById('todo-list').addEventListener('click', function(e) {
    if (e.target.classList.contains('delete-btn')) {
        var taskId = e.target.getAttribute('data-id');
        window.location.href = 'todo.jsp?delete=' + taskId;
    }
});