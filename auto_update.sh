#!/bin/sh
set -e

BUILD_DIR="$(pwd)"
MPV_DIR="$BUILD_DIR/mpv"
UPSTREAM_REPO="https://github.com/mpv-player/mpv.git"
FORK_REPO="https://github.com/Halffd/mpv.git"
BRANCH="sub-stacking"

echo "=== mpv-build auto-update ==="
echo "Fetching upstream..."
cd "$MPV_DIR"
git fetch upstream 2>/dev/null || git remote add upstream "$UPSTREAM_REPO" && git fetch upstream

echo "Fetching fork..."
git fetch origin

echo "Current branch: $(git branch --show-current)"
CURRENT_BRANCH=$(git branch --show-current)

if [ "$CURRENT_BRANCH" != "$BRANCH" ]; then
    echo "Switching to $BRANCH branch..."
    git checkout "$BRANCH" 2>/dev/null || git checkout -b "$BRANCH" origin/"$BRANCH"
fi

echo "Rebasing onto upstream/master..."
git rebase upstream/master || {
    echo "Rebase failed. Resolving..."
    git rebase --abort
    echo "Trying merge instead..."
    git merge upstream/master --no-edit || {
        echo "Merge failed. Manual intervention needed."
        exit 1
    }
}

echo "Pushing to fork..."
git push origin "$BRANCH" --force-with-lease

echo "Rebuilding..."
cd "$BUILD_DIR"
./scripts/mpv-config
./scripts/mpv-build

echo "=== Update complete ==="