module.exports = async function ({deployments, getNamedAccounts}) {
  const {deploy} = deployments;
  const {deployer} = await getNamedAccounts();

  const wklay9Adddress = hre.network.name === "baobab" ?
    "0x60Cd78c3edE4d891455ceAeCfA97EECD819209cF" :
    "0xe4f05A66Ec68B54A58B17c22107b02e0232cC817";
  const wklay10Address = (await ethers.getContract("WKLAY10")).address;

  await deploy("WklayConverter", {
    from: deployer,
    args: [wklay9Adddress, wklay10Address],
    log: true
  });
}
