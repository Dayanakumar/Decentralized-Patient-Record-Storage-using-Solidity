const HealthRecord = artifacts.require("Healthrecord");
module.exports = function (deployer) {
  deployer.deploy(HealthRecord);
};
