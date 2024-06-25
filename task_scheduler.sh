#!/bin/bash

TASK_FILE="tasks.txt"

# Function to display menu
display_menu() {
    echo "-----------------------------"
    echo " Task Scheduler Menu"
    echo "-----------------------------"
    echo "1. Add Task"
    echo "2. View Tasks"
    echo "3. Mark Task as Completed"
    echo "4. Exit"
    echo "-----------------------------"
    echo -n "Enter your choice: "
}

# Function to add a task
add_task() {
    echo -n "Enter task description: "
    read task
    echo "$task" >> "$TASK_FILE"
    echo "Task added successfully!"
}

# Function to view tasks
view_tasks() {
    if [[ ! -f "$TASK_FILE" ]]; then
        echo "No tasks found."
    else
        echo "Tasks:"
        cat -n "$TASK_FILE"
    fi
}

# Function to mark a task as completed
mark_completed() {
    view_tasks
    if [[ -f "$TASK_FILE" ]]; then
        echo -n "Enter task number to mark as completed: "
        read task_number
        sed -i "${task_number}d" "$TASK_FILE"
        echo "Task marked as completed!"
    fi
}

show_daily_notification() {
    echo "Daily Task Reminder:"
    echo "---------------------"
    cat "$TASK_FILE" | while read task; do
        notify-send "Task Reminder" "$task"
    done
}

# Main loop
while true
do
    display_menu
    read choice
    case $choice in
        1) add_task ;;
        2) view_tasks ;;
        3) mark_completed ;;
        4) echo "Exiting. Goodbye!"; break ;;
        *) echo "Invalid choice. Please enter a valid option." ;;
    esac
    echo "-----------------------------"
done


