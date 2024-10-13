async function main() {
    const VulnerableLottery = await ethers.getContractFactory("contracts/VulnerableLottery.sol:VulnerableLottery");
    const vulnerableLottery = await VulnerableLottery.deploy();
    console.log("VulnerableLottery deployed to:", vulnerableLottery.address);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
