// import MainContractV2 from "MainContractV2"
// import ExampleToken from "ExampleToken"
// import FungibleToken from "FungibleToken"


import FlowRacer from "FlowRacer"
import ExampleToken from "ExampleToken"
import FungibleToken from "FungibleToken"


transaction(matchId: UInt64, amount: UInt64){

    // The Vault resource that holds the tokens that are being transferred
    let sender: @ExampleToken.Vault
    // let vault: Capability //<&ExampleToken.Vault{FungibleToken.Receiver}>
    /// Reference to the Fungible Token Receiver of the recipient
    let tokenReceiver: &{FungibleToken.Receiver}
    let address: Address


    prepare(signer: AuthAccount){

        self.sender <- signer.borrow<&ExampleToken.Vault>(from: ExampleToken.VaultStoragePath)!.withdraw(amount: UFix64(amount)) as! @ExampleToken.Vault

        // Get the account of the recipient and borrow a reference to their receiver
        var account = getAccount(0xf8d6e0586b0a20c7)
        self.tokenReceiver = account
            .getCapability(ExampleToken.ReceiverPublicPath)
            .borrow<&{FungibleToken.Receiver}>()
            ?? panic("Unable to borrow receiver reference")

        // self.vault = signer.getCapability(ExampleToken.ReceiverPublicPath)

        self.address = signer.address

    }

    execute{

        FlowRacer.acceptWager(
            matchId: matchId, 
            amount: amount, 
            account: self.address,
            requestorVault: <- self.sender,
            receiverCapability: self.tokenReceiver
        )

    }
}