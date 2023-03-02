require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-etherscan");

module.exports = {
  solidity: { 
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 2000
      }
    }
  },
  networks: {
    goerli: {
      url: "https://eth-goerli.g.alchemy.com/v2/Yfq8Arvpbhxf3jBevx_-jITI7wrklUXe",
      accounts: [`d2536bf1124cba021fdaa9219963e90546b5f86dd46f16ad1cd49f8b4b1ef4db`]
    }
  },
  etherscan: {
    apiKey: "GV6HT4AUKY6QAJCDMBX2G5UR2V3VUED3UN"
  }
};
