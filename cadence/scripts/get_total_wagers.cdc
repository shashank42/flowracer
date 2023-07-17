// This script reads the balance field
// of an account's FlowRacerToken Balance

import FlowRacer from 0x9bac851ed05b0c54

pub fun main(): {UInt64: UInt64} {
    return FlowRacer.getTotalWagers()
}