var erc20token = artifacts.require('./erc20Token.sol');

contract('ERC20Token', function(accounts) {
  it("should assert true", function(done) {
    var erc20token = erc20token.deployed();
    assert.isTrue(true);
    done();
  });
});
