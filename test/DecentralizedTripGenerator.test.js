const { expect } = require("chai");

describe("DecentralizedTripGenerator", function () {
  
  let TripGenerator;
  let tripGenerator;
  let owner;
  let addr1;
  let addr2;

  // Deploy the contract before running tests
  beforeEach(async function () {
    TripGenerator = await ethers.getContractFactory("DecentralizedTripGenerator");
    [owner, addr1, addr2] = await ethers.getSigners();  // Get signers from the hardhat environment

    tripGenerator = await TripGenerator.deploy();
    await tripGenerator.deployed();
  });

  it("Should deploy the contract correctly", async function () {
    expect(tripGenerator.address).to.properAddress;
  });

  it("Should register a user correctly", async function () {
    const userId = 1;
    const email = "user@example.com";
    const budget = 100;

    // Register a new user
    await tripGenerator.registerUser(userId, email, budget);

    // Verify the user details
    const user = await tripGenerator.users(userId);
    expect(user.email).to.equal(email);
    expect(user.budget).to.equal(budget);
  });

  it("Should fail if a non-owner tries to register a user", async function () {
    const userId = 2;
    const email = "anotheruser@example.com";
    const budget = 200;

    // Try to register a user from a non-owner address (addr1)
    await expect(
      tripGenerator.connect(addr1).registerUser(userId, email, budget)
    ).to.be.revertedWith("OwnableUnauthorizedAccount");  // Updated to match the OpenZeppelin error message
  });

  // You can add more tests here based on the specific functionality of your contract
});

