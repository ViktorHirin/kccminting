const nft = artifacts.require("NFTmint");

module.exports = async function (deployer) {
 await deployer.deploy(nft);
};
