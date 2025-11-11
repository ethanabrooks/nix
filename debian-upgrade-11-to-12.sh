#!/usr/bin/env bash
# ============================================================================
# Debian Upgrade Script: Upgrade from Debian 11 (Bullseye) to Debian 12 (Bookworm)
# ============================================================================

# Configuration variables
INSTANCE_NAME="arnaud-workspace"
PROJECT="reflectionai"
ZONE="us-central1-a"

# ============================================================================
# LOCAL MACHINE: Create snapshot backup
# ============================================================================

gcloud config set project $PROJECT
gcloud config set compute/zone $ZONE

BOOT_DISK_URL=$(gcloud compute instances describe $INSTANCE_NAME --format='get(disks[0].source)')
BOOT_DISK=$(basename "$BOOT_DISK_URL")
echo "Boot disk: $BOOT_DISK"

SNAP="${INSTANCE_NAME}-preupgrade-$(date +%Y%m%d-%H%M%S)"
gcloud compute disks snapshot "$BOOT_DISK" --snapshot-names="$SNAP"
echo "Snapshot created: $SNAP"

# ============================================================================
# LOCAL MACHINE: SSH into instance
# ============================================================================

gcloud compute ssh $INSTANCE_NAME --zone $ZONE --project $PROJECT

# ============================================================================
# INSIDE VM: Perform the upgrade
# ============================================================================

# Backup the main sources list (Debian 11 uses sources.list, not debian.sources)
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup.bullseye

# Also backup sources.list.d files
sudo cp -r /etc/apt/sources.list.d /etc/apt/sources.list.d.backup.bullseye

# Update bullseye -> bookworm in main sources list
sudo sed -i 's/bullseye/bookworm/g' /etc/apt/sources.list

# Update any bullseye references in sources.list.d (if any)
sudo find /etc/apt/sources.list.d -type f -name "*.list" -exec sed -i 's/bullseye/bookworm/g' {} \;

# Show what we changed
echo "=== Main sources list ==="
sudo cat /etc/apt/sources.list
echo ""
echo "=== Sources list directory ==="
ls -la /etc/apt/sources.list.d/

# Update package lists
sudo apt update

# Perform minimal upgrade first (recommended by Debian upgrade guide)
sudo apt upgrade --without-new-pkgs

# Perform full upgrade
sudo apt full-upgrade

# When prompted about configuration files, choose "keep the local version currently installed"

# Clean up old packages
sudo apt autoremove
sudo apt clean

# Verify the upgrade
echo ""
echo "=== Verification ==="
lsb_release -a
echo ""
strings /usr/lib/x86_64-linux-gnu/libstdc++.so.6 | grep GLIBCXX
# Expected output should include GLIBCXX_3.4.30 or higher for Debian 12

sudo reboot

# ============================================================================
# LOCAL MACHINE: Clean up old snapshots (optional, after verifying upgrade)
# ============================================================================

gcloud compute snapshots list --filter="name~${INSTANCE_NAME}-preupgrade"
# gcloud compute snapshots delete SNAPSHOT_NAME

# ============================================================================
# ROLLBACK: Restore from snapshot if upgrade fails
# ============================================================================

# Stop the instance
gcloud compute instances stop $INSTANCE_NAME --zone=$ZONE

# Create a new disk from the snapshot
gcloud compute disks create ${INSTANCE_NAME}-restored \
  --source-snapshot=$SNAP \
  --zone=$ZONE

# Delete the current instance (keeping disks)
gcloud compute instances delete $INSTANCE_NAME --keep-disks=all --zone=$ZONE -q

# Recreate the instance with the restored disk
# NOTE: Adjust machine-type and other flags to match your original instance
gcloud compute instances create $INSTANCE_NAME \
  --zone=$ZONE \
  --machine-type=n1-standard-1 \
  --disk=name="${INSTANCE_NAME}-restored",boot=yes,auto-delete=yes \
  --scopes=https://www.googleapis.com/auth/cloud-platform

# Delete the failed upgrade disk
# gcloud compute disks delete $BOOT_DISK --zone=$ZONE -q
