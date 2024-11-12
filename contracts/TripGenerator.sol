// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";  // Importing Ownable from OpenZeppelin

contract TripGenerator is Ownable {
    struct User {
        uint256 userId;
        string email;
        uint256 budget;
        bool isVerified;
        bool isRegistered;
    }

    struct Verification {
        uint256 userId;
        string docType;
        string voterId;
        bool vStatus;
        uint256 vDate;
    }

    struct Trip {
        uint256 tripId;
        uint256 userId;
        string destination;
        uint256 budget;
        bool isVerified;
        string status;  // Pending, Confirmed, etc.
        uint256 time;
    }

    struct GeneratedTrip {
        uint256 tripId;
        string destination;
        string modelId;
        uint256 selectId;
    }

    struct Transaction {
        uint256 transactionId;
        uint256 userId;
        uint256 walletId;
        uint256 amount;
        string status;  // Success, Failed, Pending
        uint256 time;
    }

    struct Wallet {
        uint256 walletId;
        uint256 balance;
        mapping(uint256 => Transaction) transactions;  // transactionId -> Transaction
    }

    struct Block {
        uint256 blockId;
        uint256 prevNumber;
        uint256 currentNumber;
        string data;
        uint256 chainId;
        uint256 updatedAt;
    }

    struct Hotel {
        uint256 hotelId;
        string docType;
        bool isVerified;
        uint256 destinationId;
    }

    struct Destination {
        uint256 destinationId;
        string name;
        uint256 rating;
        bool isVerified;
    }

    struct SmartContractLogic {
        uint256 contractId;
        string contractAddress;
        uint256 blockChainId;
        uint256 vDate;
    }

    mapping(uint256 => User) public users;
    mapping(uint256 => Verification) public verifications;
    mapping(uint256 => Trip) public trips;
    mapping(uint256 => GeneratedTrip) public generatedTrips;
    mapping(uint256 => Wallet) public wallets;
    mapping(uint256 => Block) public blocks;
    mapping(uint256 => Hotel) public hotels;
    mapping(uint256 => Destination) public destinations;
    mapping(uint256 => SmartContractLogic) public smartContracts;

    uint256 public tripCounter;
    uint256 public transactionCounter;
    uint256 public blockCounter;

    // Events to log actions
    event TripBooked(uint256 tripId, uint256 userId, string destination);
    event TripConfirmed(uint256 tripId, uint256 userId);
    event PaymentProcessed(uint256 transactionId, uint256 userId, uint256 amount);
    event FeedbackReceived(uint256 userId, uint256 destinationId, uint256 rating);
    event AIModelGeneratedTrip(uint256 tripId, string modelId, uint256 selectId);

    // Constructor to set the owner
    constructor() Ownable(msg.sender) {
        // The Ownable constructor automatically sets the deployer as the owner
    }

    // Function to register a new user
    // Function to register a new user
    function registerUser(uint256 userId, string memory email, uint256 budget) public onlyOwner {
        require(!users[userId].isRegistered, "User already exists."); // Check if the user is already registered
        users[userId] = User(userId, email, budget, false, true); // Register the user and mark them as registered
}
    // Function to check if a user exists
    function userExists(uint256 userId) public view returns (bool) {
        return users[userId].isRegistered; // Check if the user is registered
}


    // Function to verify a user (admin-level)
    function verifyUser(uint256 userId, string memory docType, string memory voterId) public onlyOwner {
        require(!users[userId].isVerified, "User already verified.");
        verifications[userId] = Verification(userId, docType, voterId, true, block.timestamp);
        users[userId].isVerified = true;
    }

    // Function to create a trip
    function createTrip(uint256 userId, string memory destination, uint256 budget) public {
        require(users[userId].isVerified, "User is not verified.");
        require(users[userId].budget >= budget, "Insufficient budget.");

        tripCounter++;
        trips[tripCounter] = Trip(tripCounter, userId, destination, budget, true, "Pending", block.timestamp);

        // Emit event when trip is booked
        emit TripBooked(tripCounter, userId, destination);
    }

    // Function to generate a trip from AI Model
    function generateTripFromAI(uint256 tripId, string memory modelId, uint256 selectId) public {
        require(trips[tripId].isVerified, "Trip is not verified.");
        generatedTrips[tripId] = GeneratedTrip(tripId, trips[tripId].destination, modelId, selectId);

        // Emit event when AI model generates trip
        emit AIModelGeneratedTrip(tripId, modelId, selectId);
    }

    // Function to confirm the trip
    function confirmTrip(uint256 tripId) public {
        require(trips[tripId].isVerified, "Trip is not verified.");
        trips[tripId].status = "Confirmed";

        // Emit event when trip is confirmed
        emit TripConfirmed(tripId, trips[tripId].userId);
    }

    // Function to handle a payment transaction
    function processPayment(uint256 userId, uint256 amount) public {
        require(users[userId].isVerified, "User is not verified.");
        require(wallets[userId].balance >= amount, "Insufficient balance.");
        
        transactionCounter++;
        wallets[userId].balance -= amount;
        wallets[userId].transactions[transactionCounter] = Transaction(transactionCounter, userId, userId, amount, "Success", block.timestamp);

        // Emit event when payment is processed
        emit PaymentProcessed(transactionCounter, userId, amount);
    }

    // Function to add balance to the user's wallet
    function addWalletBalance(uint256 userId, uint256 amount) public onlyOwner {
        wallets[userId].balance += amount;
    }

    // Function to get user's balance
    function getWalletBalance(uint256 userId) public view returns (uint256) {
        return wallets[userId].balance;
    }

    // Function to give feedback on a destination
    function giveFeedback(uint256 userId, uint256 destinationId, uint256 rating) public {
        require(users[userId].isVerified, "User is not verified.");
        destinations[destinationId].rating = rating;

        // Emit event when feedback is received
        emit FeedbackReceived(userId, destinationId, rating);
    }

    // Function to deploy logic on the blockchain
    function deployOnBlockchain(uint256 blockId, uint256 contractId, string memory contractAddress) public {
        blockCounter++;
        blocks[blockId] = Block(blockCounter, blockId, blockCounter, "Block Data", blockCounter, block.timestamp);
        smartContracts[contractId] = SmartContractLogic(contractId, contractAddress, blockId, block.timestamp);
    }

    // Function to verify a hotel
    function verifyHotel(uint256 hotelId, string memory docType, uint256 destinationId) public onlyOwner {
        hotels[hotelId] = Hotel(hotelId, docType, true, destinationId);
    }

    // Function to confirm a destination
    function confirmDestination(uint256 destinationId) public {
        require(destinations[destinationId].isVerified, "Destination is not verified.");
        destinations[destinationId].isVerified = true;
    }
}






//npx hardhat run scripts/deploy.js --network ganache//

