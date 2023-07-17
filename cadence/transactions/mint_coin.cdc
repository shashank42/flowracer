// import FungibleToken from "FungibleToken"
// import FlowRacerToken from "FlowRacerToken"

// import FungibleToken from "FungibleToken"
// import FlowRacerToken from "FlowRacerToken"


import FungibleToken from 0x9a0766d93b6608b7
import MetadataViews from 0x631e88ae7f1d7c20

import FlowRacerToken from 0x1c5fd54be8de5259

transaction(amount: UFix64) {
    let tokenReceiver: &{FungibleToken.Receiver}
    let supplyBefore: UFix64

    prepare(signer: AuthAccount) {

        if signer.borrow<&FlowRacerToken.Vault>(from: FlowRacerToken.VaultStoragePath) != nil {
        } else {
            signer.save(
                <-FlowRacerToken.createEmptyVault(),
                to: FlowRacerToken.VaultStoragePath
            )

            signer.link<&FlowRacerToken.Vault{FungibleToken.Receiver}>(
                FlowRacerToken.ReceiverPublicPath,
                target: FlowRacerToken.VaultStoragePath
            )
            signer.link<&FlowRacerToken.Vault{FungibleToken.Balance, MetadataViews.Resolver}>(
                FlowRacerToken.VaultPublicPath,
                target: FlowRacerToken.VaultStoragePath
            )
            signer.link<&FlowRacerToken.Vault{FungibleToken.Provider}>(
                FlowRacerToken.VaultPublicPath,
                target: FlowRacerToken.VaultStoragePath
            )
        }  

        self.supplyBefore = FlowRacerToken.totalSupply

        self.tokenReceiver = signer
            .getCapability(FlowRacerToken.ReceiverPublicPath)
            .borrow<&{FungibleToken.Receiver}>()!
    }
    execute {
        
        let mintedVault <- FlowRacerToken.mintTokens(amount: amount)
        self.tokenReceiver.deposit(from: <-mintedVault)
    }
}
