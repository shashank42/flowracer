// import MainContractV2 from "MainContractV2"
// import FlowRacerToken from "FlowRacerToken"
// import FungibleToken from "FungibleToken"


// import FlowRacer from "FlowRacer"
// import FlowRacerToken from "FlowRacerToken"
// import FungibleToken from "FungibleToken"


import FungibleToken from 0x9a0766d93b6608b7
import FlowRacerToken from 0x1c5fd54be8de5259
import FlowRacer from 0x1c5fd54be8de5259

transaction(matchId: UInt64, amount: UInt64){

    let sender: @FlowRacerToken.Vault
    let address: Address

    prepare(signer: AuthAccount){

        self.sender <- signer.borrow<&FlowRacerToken.Vault>(from: FlowRacerToken.VaultStoragePath)!.withdraw(amount: UFix64(amount)) as! @FlowRacerToken.Vault

        self.address = signer.address
    }

    execute{
        FlowRacer.acceptWager(
            matchId: matchId, 
            amount: amount, 
            account: self.address,
            requestorVault: <- self.sender
        )
    }
}