#!/usr/bin/env bash
set -euo pipefail

# ▶️ 환경 변수로 외부에서 주입 가능
RPC_URL="http://10.8.0.1:32783"
PRIVATE_KEY="0x23b19fd0ba67f921bc1f5a133bfe452060d129f025fcf1be75c6964551b1208a"

# ▶️ 배포할 스크립트 리스트 (순서대로)  predictAddress를 먼저 돌리고  POLAddresses.sol에 주소 바꾸기
# SCRIPTS=(
    # "POLPredictAddresses.s.sol"
#   "script/pol/deployment/1_DeployWBERA.s.sol:DeployWBERAScript"
#   "script/pol/deployment/2_DeployBGT.s.sol:DeployBGTScript"
#   "script/pol/deployment/3_DeployPoL.s.sol:DeployPoLScript"
#   "script/pol/deployment/4_TransferPOLOWnership.s.sol:TransferPOLOwnershipScript"
#   "script/pol/deployment/5_DeployBGTIncentiveDistributor.s.sol:DeployBGTIncentiveDistributorScript"
#   "script/pol/deployment/6_TransferBGTIncentiveDistributorOwnership.s.sol:TransferPOLOwnershipScript"
# )

# SCRIPTS=(
    # "OraclesPredictAddressesScript"
# "DeployPeggedPriceOracleScript"
#   "script/oracles/deployment/1_DeployPythPriceOracle.s.sol:DeployPythPriceOracleScript"
#   "script/oracles/deployment/2_TransferPythPriceOracleOwnership.s.sol:TransferPythPriceOracleOwnershipScript"
#   "script/oracles/deployment/3_DeployRootPriceOracle.s.sol:DeployRootPriceOracleScript"
#   "script/oracles/deployment/4_TransferRootPriceOracleOwnership.s.sol:TransferRootPriceOracleOwnershipScript"
# )
# SCRIPTS=(
# DeployTokenScript
# )

# SCRIPTS=(
# "HoneyPredictAddressesScript"
# "DeployHoneyScript"
# "TransferHoneyOwnership"
# )
SCRIPTS=(
# GovernancePredictAddressesScript
DeployGovernance
)

echo "▶️ Starting sequential deployments..."
for SCRIPT in "${SCRIPTS[@]}"; do
  echo "---"
  echo "📜 Running $SCRIPT"
  forge script "$SCRIPT" \
    --broadcast \
    --rpc-url "$RPC_URL" \
    --private-key "$PRIVATE_KEY" \
    --sender 0x1e2e53c2451d0f9ED4B7952991BE0c95165D5c01 \
    --priority-gas-price 3gwei --with-gas-price 5gwei
done

echo "✅ All scripts executed."