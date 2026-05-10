#!/bin/bash
set -e

# Script to import default Authentik stages into Terraform state
# This handles the one-time import of system-created resources

AUTHENTIK_URL="${AUTHENTIK_URL:-https://auth.home.ryougi.ca}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "🔍 Importing default Authentik stages..."

# Function to get stage ID from Authentik API
get_stage_id() {
    local stage_name="$1"
    local stage_type="$2"
    
    echo "Getting ${stage_type} stage ID for: ${stage_name}" >&2
    
    local stage_id=$(curl -s \
        -H "Authorization: Bearer ${TF_VAR_authentik_bootstrap_token}" \
        "${AUTHENTIK_URL}/api/v3/stages/${stage_type}/?name=${stage_name}" | \
        jq -r '.results[0].pk // empty' 2>/dev/null)
    
    if [ -n "$stage_id" ] && [ "$stage_id" != "null" ] && [ "$stage_id" != "" ]; then
        echo "✅ Found stage ID: $stage_id" >&2
        echo "$stage_id"
    else
        echo "❌ Could not find stage: $stage_name" >&2
        return 1
    fi
}

# Function to import stage into Terraform
import_stage() {
    local terraform_resource="$1"
    local stage_id="$2"
    
    echo "Importing $terraform_resource with ID: $stage_id"
    echo "Current directory: $(pwd)"
    echo "Project directory: $PROJECT_DIR"
    
    cd "$PROJECT_DIR"
    echo "Changed to directory: $(pwd)"
    
    # Try to import and capture the result  
    echo "Running: terraform import $terraform_resource $stage_id"
    echo "Environment check - TF_VAR_authentik_bootstrap_token is: ${TF_VAR_authentik_bootstrap_token:0:10}..."
    if terraform import "$terraform_resource" "$stage_id" 2>&1; then
        echo "✅ Successfully imported $terraform_resource"
    else
        echo "⚠️  Import failed (resource might already be imported)"
        return 0
    fi
}

# Import default identification stage
echo "📋 Importing default identification stage..."
if STAGE_ID=$(get_stage_id "default-authentication-identification" "identification"); then
    import_stage "authentik_stage_identification.default_identification" "$STAGE_ID"
else
    echo "⚠️  Skipping identification stage import"
fi

echo "🎉 Stage import process complete!"