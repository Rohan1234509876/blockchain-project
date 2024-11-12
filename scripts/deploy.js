async function main() {
    // Get the contract factory
    const TripGenerator = await ethers.getContractFactory("TripGenerator");

    console.log("Deploying TripGenerator...");

    // Deploy the contract
    const tripGenerator = await TripGenerator.deploy();

    // Wait for the contract to be deployed
    await tripGenerator.deployed();

    console.log("TripGenerator deployed to:", tripGenerator.address);
}

// Execute the main function
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error("Deployment failed:", error);
        process.exit(1);
    });


  
  








