import { loadFixture } from "@nomicfoundation/hardhat-toolbox-viem/network-helpers";
import { expect } from "chai";
import hre from "hardhat";
import { bytesToHex, hexToString, toBytes } from "viem";

describe("Generator", function () {
  async function deployGeneratorFixture() {
    // Contracts are deployed using the first signer/account by default
    const wallets = await hre.viem.getWalletClients();
    const generator = await hre.viem.deployContract("Generator");
    return {
      generator,
      wallets,
    };
  }

  describe("Deployment", function () {
    it("Should set the right UUID", async function () {
      const { generator, wallets } = await loadFixture(deployGeneratorFixture);
      for (const wallet of wallets) {
        const uuid = await generator.read.generateUUID([
          bytesToHex(toBytes("b4bfd45af0f04380b9d355c52d90e461")),
          wallet.account.address,
        ]);
        const uuidString = hexToString(uuid);
        console.log(uuidString);
        console.log(bytesToHex(toBytes(uuidString)) === uuid);
      }
    });
  });
});
