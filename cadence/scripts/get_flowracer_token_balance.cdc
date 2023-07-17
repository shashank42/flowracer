

import FungibleToken from 0x9a0766d93b6608b7
import FlowRacerToken from 0x9bac851ed05b0c54

pub fun main(address: Address): UFix64 {
    let account = getAccount(address)
    let vaultRef = account.getCapability(FlowRacerToken.VaultPublicPath)
        .borrow<&FlowRacerToken.Vault{FungibleToken.Balance}>()
        ?? panic("Could not borrow Balance reference to the Vault")

    return vaultRef.balance
}
