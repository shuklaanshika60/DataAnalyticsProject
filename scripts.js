document.addEventListener("DOMContentLoaded", function() {
    // Total Employees Chart (Simple Gauge or Doughnut)
    const totalEmployeesCtx = document.getElementById('totalEmployeesChart').getContext('2d');
    new Chart(totalEmployeesCtx, {
        type: 'doughnut',
        data: {
            labels: ['Total Employees'],
            datasets: [{
                label: 'Total Employees',
                data: [15, 100 - 15],
                backgroundColor: ['#42a5f5', '#e0e7ff'],
                borderWidth: 0,
            }]
        },
        options: {
            cutout: '70%',
            plugins: {
                tooltip: { enabled: false },
                legend: { display: false },
            }
        }
    });

    // Average Rating (Doughnut Chart)
    const averageRatingCtx = document.getElementById('averageRatingChart').getContext('2d');
    new Chart(averageRatingCtx, {
        type: 'doughnut',
        data: {
            labels: ['Rating', 'Remaining'],
            datasets: [{
                label: 'Average Rating',
                data: [7.5, 10 - 7.5],
                backgroundColor: ['#ffca28', '#ffe082'],
                borderWidth: 0,
            }]
        },
        options: {
            cutout: '70%',
            plugins: {
                tooltip: { enabled: false },
                legend: { display: false },
            }
        }
    });

    // Task Status Distribution (Pie Chart)
    const taskStatusCtx = document.getElementById('taskStatusChart').getContext('2d');
    new Chart(taskStatusCtx, {
        type: 'pie',
        data: {
            labels: ['Completed', 'In Progress', 'Overdue'],
            datasets: [{
                label: 'Task Status',
                data: [10, 5, 2],
                backgroundColor: ['#66bb6a', '#ffa726', '#ef5350'],
                borderWidth: 1
            }]
        },
    });

    // Employee Task Completion (Bar Chart)
    const taskCompletionCtx = document.getElementById('taskCompletionChart').getContext('2d');
    new Chart(taskCompletionCtx, {
        type: 'bar',
        data: {
            labels: ['Alice Johnson', 'Bob Smith'],
            datasets: [{
                label: 'Completed Tasks',
                data: [8, 5],
                backgroundColor: '#42a5f5',
                borderWidth: 1
            }]
        },
    });

    // Goal Completion Status (Doughnut Chart)
    const goalCompletionCtx = document.getElementById('goalCompletionChart').getContext('2d');
    new Chart(goalCompletionCtx, {
        type: 'doughnut',
        data: {
            labels: ['Achieved', 'In Progress', 'Not Achieved'],
            datasets: [{
                label: 'Goal Completion',
                data: [5, 7, 3],
                backgroundColor: ['#66bb6a', '#ffa726', '#ef5350'],
                borderWidth: 1
            }]
        },
    });

    // Overdue Tasks by Employee (Horizontal Bar Chart)
    const overdueTasksCtx = document.getElementById('overdueTasksChart').getContext('2d');
    new Chart(overdueTasksCtx, {
        type: 'bar',
        data: {
            labels: ['Charlie Davis', 'Diana Garcia'],
            datasets: [{
                label: 'Overdue Tasks',
                data: [3, 2],
                backgroundColor: '#ef5350',
                borderWidth: 1
            }]
        },
        options: {
            indexAxis: 'y'
        }
    });
});
