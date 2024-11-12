require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");

module.exports = {
  solidity: "0.8.20",
  networks: {
    ganache: {
      url: "http://127.0.0.1:7545", // Ganache RPC server
      accounts: [ `0x588604f39b64a2e4e6abb12d1eab6e4adb52b062350e58f176ba353912665082` ] // Private key from Ganache
    }
  }
};

//  0xCfA0a9F4FC8c814581946959aaB0bA1530D356FB//


