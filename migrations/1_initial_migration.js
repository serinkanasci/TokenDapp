const Tokens = artifacts.require("Token");

module.exports = function (deployer) {
  deployer.deploy(Tokens);
};
