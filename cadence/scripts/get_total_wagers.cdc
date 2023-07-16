// This script reads the balance field
// of an account's ExampleToken Balance

import FlowRacer from "FlowRacer"

pub fun main(): {UInt64: UInt64} {
    // let account = getAccount(address)
    // let vaultRef = account.getCapability(ExampleToken.VaultPublicPath)
    //     .borrow<&ExampleToken.Vault{FungibleToken.Balance}>()
    //     ?? panic("Could not borrow Balance reference to the Vault")

    return FlowRacer.getTotalWagers()
}