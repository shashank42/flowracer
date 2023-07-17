// Cadence contract for managing a wager between players
import FlowRacerToken from "FlowRacerToken"
import FungibleToken from "FungibleToken"

pub contract FlowRacer {

    // Declare a type for representing a wager
    pub struct MatchWager {
        // pub(set) var totalWager: UInt64
        pub(set) var players: [Player]
        pub(set) var finished: Bool

        init(
            // totalWager : UInt64,
            players : [Player],
            finished: Bool
        ) {
            // self.totalWager = totalWager
            self.players = players
            self.finished = finished
        }
    }

    // Declare a type for representing player information
    pub struct Player {
        pub var address: Address
        pub var wager: UInt64

        init(
            address : Address,
            wager : UInt64
        ) {
            self.address = address
            self.wager = wager
        }

    }

    pub var wagers: {UInt64: MatchWager}
    pub var totalWagers: {UInt64: UInt64}


    // // Declare an interface for the admin capability
    // pub resource interface Admin {
    //     pub fun distributeWager(matchId: UInt32, winner: Address)
    // }

    // // Declare an interface for the token capability
    // pub resource interface Token {
    //     pub fun mintTokens(to: Address, amount: UInt64)
    //     pub fun transfer(from: Address, to: Address, amount: UInt64)
    // }

    // // Declare a reference to the admin capability
    // pub var adminCapability: Capability<&AnyResource{WagerContract.Admin}>

    // // Declare a reference to the token capability
    // pub var tokenCapability: Capability<&AnyResource{WagerContract.Token}>

    // Initialize the contract with admin and token capabilities
    init() {
        // self.adminCapability = adminCap
        // self.tokenCapability = tokenCap


        self.wagers = {}
        self.totalWagers = {}

        // // Link the capabilities
        // self.account.link<&Admin>(self.adminCapability, target: /private/AdminStoragePath)
        // self.account.link<&Token>(self.tokenCapability, target: /private/TokenStoragePath)
    }

    // Accept a wager against a matchId and store the player's wager
    pub fun acceptWager(
        matchId: UInt64, 
        amount: UInt64, 
        account: Address,
        requestorVault: @FlowRacerToken.Vault
    ) {
        let player = Player(address: account, wager: amount)
        if self.wagers[matchId] != nil {
        } else 
        {
            self.wagers[matchId] = MatchWager(players: [] as [Player], finished: false)
        }
        self.wagers[matchId]?.players?.append(player)
        // self.wagers[matchId]?.totalWager = self.wagers[matchId]?.totalWager + amount

        self.totalWagers[matchId] = self.totalWagers[matchId] ?? UInt64(0)
        self.totalWagers[matchId] = self.totalWagers[matchId]! + amount


        let tokenProvider = self.account.getCapability(FlowRacerToken.ReceiverPublicPath).borrow<&{FungibleToken.Receiver}>()!
        tokenProvider.deposit(from: <- requestorVault)
    }

    // Distribute the total wager amount among players when the match ends
    pub fun distributeWager(
        matchId: UInt64, 
        winner: Address,
        responderRecievingCapability: &{FungibleToken.Receiver}
    ) {
        let totalWagerAmount = self.totalWagers[matchId] ?? UInt64(0)
        let tokenProvider = self.account.getCapability<&FlowRacerToken.Vault>(/private/exampleTokenVault)
        responderRecievingCapability.deposit(from: <- tokenProvider.borrow()!.withdraw(amount: UFix64(totalWagerAmount)))
    }

    pub fun getAllWagers(): {UInt64: MatchWager} {
        return self.wagers
    }

    pub fun getTotalWagers(): {UInt64: UInt64} {
        return self.totalWagers
    }

}