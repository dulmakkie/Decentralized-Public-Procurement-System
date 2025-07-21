# Decentralized Public Procurement System

A blockchain-based procurement system built on Stacks that ensures transparency, fairness, and automation in government contracting processes.

## System Overview

This system consists of five interconnected smart contracts that manage the entire procurement lifecycle:

### 1. Bid Submission Contract (`bid-submission.clar`)
- Manages contractor proposals for government projects
- Handles bid creation, submission, and retrieval
- Enforces bidding deadlines and requirements
- Stores bid details securely on-chain

### 2. Vendor Qualification Contract (`vendor-qualification.clar`)
- Verifies contractor credentials and past performance
- Manages vendor registration and certification
- Tracks qualification scores and ratings
- Maintains vendor reputation system

### 3. Award Transparency Contract (`award-transparency.clar`)
- Ensures fair and transparent contract awarding process
- Records award decisions with justifications
- Implements scoring algorithms for bid evaluation
- Provides public audit trail for all awards

### 4. Payment Automation Contract (`payment-automation.clar`)
- Processes milestone payments upon work completion
- Manages escrow funds for projects
- Automates payment releases based on milestones
- Handles payment disputes and resolutions

### 5. Performance Tracking Contract (`performance-tracking.clar`)
- Monitors contractor performance and compliance
- Records project milestones and deliverables
- Tracks performance metrics and KPIs
- Generates performance reports for future reference

## Key Features

- **Transparency**: All procurement activities are recorded on-chain
- **Automation**: Smart contracts automate payments and processes
- **Fairness**: Algorithmic bid evaluation reduces bias
- **Accountability**: Immutable audit trail for all decisions
- **Efficiency**: Streamlined processes reduce administrative overhead

## Contract Architecture

\`\`\`
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│ Bid Submission  │────│ Award Transparency│────│ Payment Auto    │
└─────────────────┘    └──────────────────┘    └─────────────────┘
│                        │                        │
│              ┌─────────────────┐                │
└──────────────│ Vendor Qualify  │────────────────┘
└─────────────────┘
│
┌─────────────────┐
│ Performance     │
│ Tracking        │
└─────────────────┘
\`\`\`

## Data Structures

### Project
- `project-id`: Unique identifier
- `title`: Project name
- `description`: Project details
- `budget`: Maximum budget
- `deadline`: Submission deadline
- `status`: Current project status

### Bid
- `bid-id`: Unique identifier
- `project-id`: Associated project
- `vendor`: Bidding contractor
- `amount`: Bid amount
- `timeline`: Proposed timeline
- `proposal`: Detailed proposal

### Vendor
- `vendor-id`: Unique identifier
- `name`: Company name
- `credentials`: Certifications
- `rating`: Performance rating
- `status`: Qualification status

## Usage

### For Government Agencies
1. Deploy contracts and initialize system
2. Create procurement projects
3. Set bidding parameters and deadlines
4. Review and award contracts transparently
5. Monitor performance and process payments

### For Contractors
1. Register and get qualified as vendor
2. Browse available projects
3. Submit competitive bids
4. Deliver work according to milestones
5. Receive automated payments

## Security Features

- Multi-signature requirements for critical operations
- Role-based access control
- Input validation and error handling
- Reentrancy protection
- Emergency pause functionality

## Testing

The system includes comprehensive tests covering:
- Contract deployment and initialization
- Bid submission and validation
- Vendor qualification processes
- Award transparency mechanisms
- Payment automation flows
- Performance tracking accuracy

## Deployment

1. Install Clarinet CLI
2. Configure network settings
3. Deploy contracts in dependency order
4. Initialize system parameters
5. Set up governance roles

## Governance

The system supports decentralized governance through:
- Multi-signature wallets for admin functions
- Proposal-based parameter updates
- Community voting on system changes
- Transparent decision-making processes
