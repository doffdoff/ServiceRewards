# ServiceRewards

ServiceRewards is a blockchain-based volunteer service tracking system built on the Stacks blockchain that records community contributions and distributes rewards to incentivize civic engagement.

## Features

- **Service Tracking**: Record and verify volunteer hours on the blockchain
- **Proportional Rewards**: Earn rewards based on your contribution to the overall service pool
- **Transparent Distribution**: Fair and transparent bonus allocation for community service
- **Immutable Records**: Blockchain-based records ensure volunteer accountability

## Smart Contract Functions

### Administration
- `establish-community`: Set up the ServiceRewards system with a community coordinator
- `distribute-volunteer-bonuses`: Calculate and distribute bonus points based on time elapsed

### Volunteer Functions
- `log-service-hours`: Record new volunteer hours and add them to your total contributions
- `claim-service-rewards`: Claim your accumulated contributions and proportional bonuses

## Getting Started

1. Clone this repository
2. Install [Clarinet](https://github.com/hirosystems/clarinet) for local development
3. Run `clarinet check` to verify the contract
4. Deploy using Clarinet or the Stacks CLI

## For Volunteers

Volunteers can record their service hours and claim rewards proportional to their contribution to the overall community service effort.

## For Community Organizations

Organizations can use this system to incentivize consistent volunteer participation and create a competitive yet collaborative community service environment.

## Technical Details

- Volunteer hours are tracked per volunteer address
- Bonuses accumulate over time based on block height
- Rewards are distributed proportionally based on contribution to the service pool
- All transactions are recorded on the Stacks blockchain for transparency