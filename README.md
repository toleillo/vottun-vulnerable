# Vottun Vulnerable Contract

Install dependencies

```shell
npx install
```

# Compile Contracts

```shell
npx hardhat compile
```

Start Hardhat Node: In a separate terminal, start a local blockchain:

```shell
npx hardhat node
```

Deploy VulnerableLottery: In another terminal, deploy the vulnerable contract:

```shell
npx hardhat run scripts/deployVulnerableLottery.js --network localhost
```

Copy the deployed contract's address and replace "ADDRESS_OF_VULNERABLE_LOTTERY" in the exploit deployment script.
Deploy ExploitLottery: After replacing the vulnerable contract’s address in deployExploitLottery.js, deploy the exploit contract:

```shell
npx hardhat run scripts/deployExploitLottery.js --network localhost
```

# Simulate the Attack
Once the contracts are deployed, use the Hardhat console to simulate the attack.
Open Hardhat Console:

```shell
npx hardhat console --network localhost
```

Set up contract instances: Inside the console, create instances of the deployed contracts:

```javascript
ethers.getContractAt("contracts/VulnerableLottery.sol:VulnerableLottery", "VULNERABLE_CONTRACT_ADDRESS");
const exploit = await ethers.getContractAt("ExploitLottery", "EXPLOIT_CONTRACT_ADDRESS");

const [owner, player1, player2] = await ethers.getSigners();
```

*Simulate lottery entries*: Some players enter the lottery:

```javascript
await vulnerable.connect(player1).enter({ value: ethers.parseUnits("1", "ether") });
await vulnerable.connect(player2).enter({ value: ethers.parseUnits("1", "ether") });

// Check lottery contract balance
const balance = await ethers.provider.getBalance(await vulnerable.getAddress());
console.log("Lottery balance:", ethers.formatEther(balance));  // Should be 2 Ether
```

*Exploit the vulnerability*:
Call the exploit contract to trigger the lottery’s winner selection early:

```javascript
await exploit.connect(owner).attack();

const recentWinner = await vulnerable.recentWinner();
console.log("Recent winner:", recentWinner);
```



