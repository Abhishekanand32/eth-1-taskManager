# TaskManager Smart Contract

This Solidity program is a simple TaskManager contract that demonstrates the basic syntax and functionality of the Solidity programming language. The purpose of this program is to serve as a starting point for those who are new to Solidity and want to understand how it works.

## Description

This program is a basic TaskManager contract written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain. The contract includes functionalities such as addAssignment, getAssignments, markAssignmentDone, and modifyDueDate. It serves as a straightforward introduction to Solidity programming and can be used as a foundation for more complex projects in the future.

In this smart contract we also implements the require(), assert() and revert() statements.

- require(): Used for input validation and precondition checks, ensuring certain conditions are met before proceeding.
- revert(): Handles exceptions by reverting transactions, undoing state changes, and providing error messages.
- assert(): Used for internal error checking, catching programming errors and ensuring invariants hold true.

## Getting Started

### Executing Program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at [Remix IDE](https://remix.ethereum.org/).

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a `.sol` extension (e.g., `TaskManager.sol`). Copy and paste the following code into the file:

```solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TaskManager {

    struct Assignment {
        string description; // details of the assignment
        uint dueDate; // assignment deadline
        bool isDone; // completion status
        bool isDueDateChanged; // flag for due date modification
    }

    mapping(address => Assignment[]) private assignmentsByUser;

    function addAssignment(string memory _description, uint _dueDate) public {
        if (bytes(_description).length == 0) {
            revert("Assignment description cannot be empty");
        }

        assignmentsByUser[msg.sender].push(Assignment({
            description: _description,
            dueDate: _dueDate,
            isDone: false,
            isDueDateChanged: false
        }));
    }

    function markAssignmentDone(uint _assignmentIndex, bool _isDone) public {
        assert(_assignmentIndex < assignmentsByUser[msg.sender].length);
        assignmentsByUser[msg.sender][_assignmentIndex].isDone = _isDone;
    }

    function modifyDueDate(uint _assignmentIndex, uint _newDueDate) public {
        require(_assignmentIndex < assignmentsByUser[msg.sender].length, "Invalid assignment index");
        require(!assignmentsByUser[msg.sender][_assignmentIndex].isDueDateChanged, "Due date can only be modified once");
        assignmentsByUser[msg.sender][_assignmentIndex].dueDate = _newDueDate;
        assignmentsByUser[msg.sender][_assignmentIndex].isDueDateChanged = true;
    }

    function getAssignments() public view returns (Assignment[] memory) {
        return assignmentsByUser[msg.sender];
    }
}

```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile TaskManager.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "TaskManager" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it by calling the addAssignment, getAssignments, markAssignmentDone, and modifyDueDate functions. For example, you can create a new assignment by providing a description and due date. Similarly, you can mark assignments as completed or modify their due dates.


## License

This project is licensed under the MIT License
