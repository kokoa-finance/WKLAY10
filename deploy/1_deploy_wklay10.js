module.exports = async function ({ethers, deployments, getNamedAccounts, getChainId}) {
  const {deploy} = deployments;
  const {deployer} = await getNamedAccounts();
  const chainId = await getChainId();

  await deploy("WKLAY10", {
    from: deployer,
    log: true,
    args: [chainId]
  });
}
module.exports.tags = ["WKLAY10"]
