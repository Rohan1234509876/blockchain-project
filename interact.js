const { ethers } = require("hardhat");

async function main() {
    // Get the contract factory
    const TripGenerator = await ethers.getContractFactory("TripGenerator");
    
    // Connect to the deployed contract
    const contractAddress = "0xCfA0a9F4FC8c814581946959aaB0bA1530D356FB"; // Replace with your deployed contract address
    const tripGenerator = await TripGenerator.attach(contractAddress);

    // User data to register
    const userId = 2;
    const email = "testuser@example.com";
    const walletBalance = 1000;

    // Log user data
    console.log("Registering user with ID:", userId);
    console.log("User email:", email);
    console.log("Wallet balance:", walletBalance);

    try {
        // Interact with the contract to register a user
        const tx = await tripGenerator.registerUser(userId, email, walletBalance);
        
        // Wait for the transaction to be mined
        await tx.wait();
        
        console.log("User registered successfully!");
    } catch (error) {
        console.error("Error interacting with the contract:", error);
    }
}

// Execute the main function
main().catch((error) => {
    console.error("Error in main execution:", error);
    process.exitCode = 1;
});










    //npx hardhat run interact.js --network ganache//


