// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TaskManager {

    struct Assignment {
        string description; // details of the assignment
        uint dueDate; // assignment deadline
        bool isDone; // completion status
        bool isDueDateChanged; // flag for due date modification
    }

    mapping(address => Assignment[]) private assignmentsByUser; // mapping of user addresses to their assignment lists

    function addAssignment(string memory _description, uint _dueDate) public {
        // Ensure the description is not empty
        if (bytes(_description).length == 0) {
            revert("Assignment description cannot be empty");
        }

        // Add a new assignment to the user's list
        assignmentsByUser[msg.sender].push(Assignment({
            description: _description,
            dueDate: _dueDate,
            isDone: false,
            isDueDateChanged: false
        }));
    }

    function markAssignmentDone(uint _assignmentIndex, bool _isDone) public {
        // Ensure the assignment index is valid
        assert(_assignmentIndex < assignmentsByUser[msg.sender].length);

        // Update the assignment's completion status
        assignmentsByUser[msg.sender][_assignmentIndex].isDone = _isDone;
    }

    function modifyDueDate(uint _assignmentIndex, uint _newDueDate) public {
        // Ensure the assignment index is valid and the due date hasn't already been changed
        require(_assignmentIndex < assignmentsByUser[msg.sender].length, "Invalid assignment index");
        require(!assignmentsByUser[msg.sender][_assignmentIndex].isDueDateChanged, "Due date can only be modified once");

        // Update the assignment's due date and mark it as changed
        assignmentsByUser[msg.sender][_assignmentIndex].dueDate = _newDueDate;
        assignmentsByUser[msg.sender][_assignmentIndex].isDueDateChanged = true;
    }

    function getAssignments() public view returns (Assignment[] memory) {
        // Return the assignments for the user
        return assignmentsByUser[msg.sender];
    }
}
