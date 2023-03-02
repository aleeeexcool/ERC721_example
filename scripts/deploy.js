const hre = require("hardhat");

async function main() {
    const CoolBearsCollection = await hre.ethers.getContractFactory("CoolBearsCollection");
    const Collection = await CoolBearsCollection.deploy();

    await Collection.deployed();

    console.log("CoolBearsCollection deployed to:", Collection.address);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
