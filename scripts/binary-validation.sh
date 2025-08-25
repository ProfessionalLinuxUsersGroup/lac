#!/bin/bash

# binary-validator.sh v1.1.0
#
# Authored by:
# github.com/cmckee786
# github.com/Kolkhis
#
# Targeting mdBook version v0.4.52 as of Aug, 2025
# Only requests 5 latest release records, remove ?per_page=5 to
# fetch all from logic to request all records
#
# Requires mdBook semantic version input from command line
# For example 'binary-validation.sh v0.1.15'

set -eo pipefail

declare MDBOOK_VERSION
declare SKIP_DIGEST=0
declare INTERACTIVE=0
declare EXTRACT=0

declare json
reg_pattern='^v?([0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}$)'

usage() {
    printf "
    SYNOPSIS
    This script attempts to download and validate the mdBook binary directly from the GitHub API for
    automatic deployment of mdBook documentation workflows.

    JSON GitHub records will be pulled down and parsed with jq, the targeted mdBook version zip file
    will be pulled down if found and validated against the GitHub sha digest value and the local sha256sum
    digest value, and finally extracted for use.


    USAGE
        ./binary-validation.sh \$version [options] [-s][-i][-h]

    OPTIONS
        -s      Skips GitHub API sha256 digest check logic, usually used with a non-interactive call of
                the script when it is known the version does not support the digest check. Practical for
                testing or debug purposes.

        -i      Should be used when the mdBook version has an unknown/null digest check value. This option will
                prompt the user whether to continue the download if it does not detect the sha digest. Practical
                for local dev purposes.

        -h      Display this help message.
        "
}

while getopts "sih" option; do
    case "$option" in
    s) SKIP_DIGEST=1 ;;
    i) INTERACTIVE=1 ;;
    h)
        usage
        exit;;
    \?)
        printf >&2 "Unknown argument!\n./binary-validation.sh \$version [options] [-s][-i][-h]"
        exit 1
        ;;
    esac
done

if [ "$OPTIND" -gt "$#" ]; then
    echo "Missing mdBook version!"
    exit 1
fi

shift $(($OPTIND - 1))
if [[ -n "$1" && "$1" =~ $reg_pattern ]]; then
    MDBOOK_VERSION="$1"
elif [[ ! "$1" =~ $reg_pattern ]]; then
    printf >&2 "Unrecognized mdBook version pattern, script accepts semantic version for example: 0.4.52"
    exit 1
fi

# If the mdbook version is pre-digest version (<0.4.52), ask for user validation
interactive-download() {
    if [[ $INTERACTIVE -gt 0 ]]; then
        local -l choice
        until [[ $choice =~ ^[Yy|nN]$ ]]; do
            read -r -p "Do you want to continue [y/N]? " choice
            choice=${choice:-N}
            case $choice in
            y*)
                printf "Proceeding with download.\n"
                EXTRACT=1
                ;;
            n*)
                printf "Cancelling download.\n"
                ;;
            *)
                printf "Invalid input! Please choose [y/N]. \n"
                ;;
            esac
        done
    else
        printf "Non-interactive download, proceeding...\n"
        return 0
    fi
}

json_setup() {

    if [[ ! $MDBOOK_VERSION =~ v ]]; then
        MDBOOK_VERSION="v$MDBOOK_VERSION"
    fi
    local jquery="
	map(select(.tag_name==\"$MDBOOK_VERSION\"))
	| .[].assets
	| map(select(.name==\"mdbook-$MDBOOK_VERSION-x86_64-unknown-linux-gnu.tar.gz\"))
	"
    printf "mdBook Binary script executing...\n"
    printf "Querying GH API for JSON %s mdBook record...\n" "$MDBOOK_VERSION"

    json="$(curl -sL \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        https://api.github.com/repos/rust-lang/mdBook/releases?per_page=5 |
        jq "$jquery")" ||
        {
            printf "Something went wrong with the GH API request. Consider adding set -x flag.\n" 1>&2
            return 1
        }

    # TODO Implement GH TOKEN in the future?
    # gh api repos/rust-lang/mdBook/releases?per_page=5 --jq "${jquery}" > "${json}"||
    # 	{
    # 		printf "Something may have gone wrong with the GH API request.\n" >&2
    # 		exit 1
    # 	}
}

binary_fetch() {

    if [[ -n "$json" ]]; then
        printf "Parsing API JSON return data and fetching binary...\n\n"
        curl -LO --progress-bar "$(jq -r '.[].browser_download_url' <<<"$json")" || {
            printf >&2 "Failed to download mkBook binary!\n" && return 1
        }
        printf "\n"
    else
        printf "\nThe processed JSON record appears to be empty, queried version may not exist...\nExiting..."
        return 1
    fi
}

validation-decision() {
    local api_digest
    local zip_digest
    local zip

    api_digest="$(jq -r '.[].digest' <<<"${json}" | cut -d: -f2)"
    zip="$(jq -r '.[].name' <<<"$json")"
    zip_digest="$(sha256sum "$zip" | awk '{print $1}')"

    printf "%2s %s\n" "ZIP:" "$zip" "API_DIGEST:" "$api_digest"
    printf "ZIP_DIGEST: %s\n\n" "$zip_digest"

    if [[ $SKIP_DIGEST -eq 1 ]]; then
        EXTRACT=1
        printf "Skipping digest check, fetching binary...\n"
    elif [[ "$api_digest" == 'null' && $INTERACTIVE -eq 1 ]]; then
        printf "This version of mdBook (%s) pre-dates the SHA digest feature of the GitHub API and cannot be validated.\n" "$MDBOOK_VERSION"
        interactive-download || {
            printf >&2 "Could not proceed with download.\n"
        }
    elif [[ "$api_digest" == "$zip_digest" && $INTERACTIVE -eq 1 ]]; then
        printf "The mdBook binary has been successfully validated.\n"
        interactive-download || {
            printf >&2 "Could not proceed with download.\n"
        }
    elif [[ "$api_digest" == 'null' ]]; then
        printf "Digest could not be gathered from the API, likely an older version (<0.4.52).\nExiting..."
    elif [[ "$api_digest" = "$zip_digest" ]]; then
        printf "Digest check succeeded!\n"
        EXTRACT=1
    else
        printf "\nThe API digest appears to be different than the downloaded binary digest:"
        printf "\n%2s %s" "API sha:" "$api_digest" "ZIP sha:" "$zip_digest"
        printf "\n\nDumping JSON record and exiting...\n\n"
        echo "$json" | jq '.'
    fi

    if [[ $EXTRACT -eq 1 ]]; then
        tar xfz "$zip"
        printf "Extracting binary for use...\nBinary is ready for use!"
    fi
    [[ -e $zip ]] && rm -f "$zip"
}

if [[ -n "$MDBOOK_VERSION" ]]; then
    json_setup
    binary_fetch
    validation-decision || {
        printf >&2 "Digest check failed!\n"
    }
else
    printf >&2 "MDBOOK_VERSION appears to be empty! Script requires a semantic version, for example: 0.4.52\n"
fi

