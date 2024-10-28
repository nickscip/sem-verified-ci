# This script bumps the project's version number, creates a new tag, and updates the CHANGELOG.md file.
#!/bin/bash

set -e

<<<<<<< Updated upstream
<<<<<<< Updated upstream
=======
=======
>>>>>>> Stashed changes
if ! [ -x "$(command -V git-cliff)" ]; then
        echo 'Error: git-cliff is not installed.' >&2
        exit 1
fi

if ! [ -x "$(command -V poetry)" ]; then
        echo 'Error: poetry is not installed.' >&2
        exit 1
fi

if ! [ -x "$(command --version gh)" ]; then
        echo 'Error: gh is not installed.' >&2
        exit 1
fi

<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
REPO="https://$GH_TOKEN@github.com/$https://github.com/nickscip/cicd-testing.git"
MAIN_BRANCH="main"
DEV_BRANCH="dev"

git checkout $MAIN_BRANCH
git fetch --all

<<<<<<< Updated upstream
<<<<<<< Updated upstream
echo "Setting up Python environment"
python3 -m pip install --upgrade pip
if [ -f requirements/requirements.ci.txt ]; then
  pip install -r requirements/requirements.ci.txt
fi
=======
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes

echo "Generating changelog"
git-cliff --verbose --bump -o CHANGELOG.md

NEW_TAG=$(git cliff --bumped-version)
echo "NEW_TAG=$NEW_TAG"

poetry version "$NEW_TAG"

git config user.name 'nickscip'
git config user.email 'nickscip@gmail.com'
git add CHANGELOG.md pyproject.toml
git commit -m "Update changelog"
git push "$REPO" "$MAIN_BRANCH"

echo "Creating GitHub release for tag $NEW_TAG"
gh release create "$NEW_TAG" -F CHANGELOG.md -t "$NEW_TAG" --repo "$GITHUB_REPOSITORY" --generate-notes

echo "Updating dev branch"
git pull "$REPO" "$MAIN_BRANCH"
git checkout "$DEV_BRANCH"
git rebase "$MAIN_BRANCH"
git push "$REPO" "$DEV_BRANCH"

echo "Script completed successfully!"
