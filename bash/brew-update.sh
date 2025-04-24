#!/usr/bin/env bash

# FILENAME:    ~/bin/brew-update.sh
# VERSION:     2025-04-24_15-25
# LICENSE:     WTFPL
# DESCRIPTION: Script that "properly" Updates libreoffice with brew/mac without
#              breaking the libreoffice-language-pack.
#              Yes. This is a bodge!
#              The proper/sane solution is to use a proper Linux distribution with
#              a proper package manager like Debian with dpkg/apt and not use shitty/
#              proprietary operating systems. ;-)
# CHANGELOG:
#  * 2025-04-24_15-25: refactoring comments/output, add changelog
#    * refactor comments and output to only use english
#    * add this changelog
#
#  * 2025-04-23_14-40: re-add libreoffice to dock if it was there before updating
#    * install dockutil with brew as dependency if not already installed
#    * find out if libreoffice is in the dock and if so note the position
#    * if libreoffice is uninstalled/reinstalled for the update and it was
#      in the dock previously it will be re-added at the correct position
#      in the dock where it was before
#    * minor refactoring: quote vars to prevent globbing
#
#  * 2025-03-07_13-45: minor bugfixes (include --greedy for casks)
#
#  * 2025-02-28_14-10: initial release
#

set -uo pipefail;

sudo -v;

# find out if docutil is installed
IS_INSTALLED_DOCKUTIL=$(brew list | grep -c 'dockutil');
if [[ "${IS_INSTALLED_DOCKUTIL}" -eq 0 ]]
then
  echo " brew install dockutil";
  brew install dockutil;
  echo "";
fi

# check if LibreOffice has been placed in the dock and at which position
echo " dockutil --find \"LibreOffice\" # Checking if LibreOffice is in the Dock.";
dockutil --find "LibreOffice";
FOUND_LIBREOFFICE_IN_DOCK=${?};
if [[ "${FOUND_LIBREOFFICE_IN_DOCK}" -eq 0 ]]
then
  POSITION_OF_LIBREOFFICE_IN_DOCK=$(dockutil --find "LibreOffice" | awk -F 'slot ' '{print $2}' | awk -F ' in' '{print $1}');
  echo "";
fi


IS_INSTALLED_LIBREOFFICE=$(brew list --casks | grep -c 'libreoffice');
IS_INSTALLED_LIBREOFFICE_LANGPACK=$(brew list --casks | grep -c 'libreoffice-language-pack');

if [[ "${IS_INSTALLED_LIBREOFFICE}" -ne 0 ]]
then
  LIBREOFFICE_OUTDATED_CHECK=$(brew outdated --cask | grep -c libreoffice);
  if [ "${LIBREOFFICE_OUTDATED_CHECK}" -ne 0 ];
  then

    if [[ "${IS_INSTALLED_LIBREOFFICE_LANGPACK}" -ne 0 ]]
    then
      # LibreOffice AND language pack are installed.
      echo "==> Checking if there are updates available for LibreOffice ...";


      LIBREOFFICE_AVAILABLE_VERSION=$(brew outdated --casks --greedy --json | jq .casks | jq '.[] | select(.name=="libreoffice")' | jq .current_version | tr -d '"');
      LIBREOFFICE_LANGPACK_AVAILABLE_VERSION=$(brew outdated --casks --greedy --json | jq .casks | jq '.[] | select(.name=="libreoffice-language-pack")' | jq .current_version | tr -d '"');

      if [[ "${LIBREOFFICE_AVAILABLE_VERSION}" == "${LIBREOFFICE_LANGPACK_AVAILABLE_VERSION}" ]]
      then
        echo "==> A LibreOffice update is available. :-)";

        # deinstallieren
        echo " brew uninstall --cask libreoffice";
        brew uninstall --cask libreoffice;

        echo " brew uninstall --cask libreoffice-language-pack";
        brew uninstall --cask libreoffice-language-pack;

        # installieren
        ## LibreOffice installieren
        echo " brew install --cask --no-quarantine libreoffice";
        brew install --cask --no-quarantine libreoffice;

        if [ -d /Applications/LibreOffice.app ];
        then
          ## Check if the operating system's index (Spotlight?) has already added LibreOffice. If not sleep for a second and try again.
          ## As long as the OS's index does not contain /Applications/LibreOffice.app yet the language pack can NOT be installed silently/automatically!
          echo " ... please wait";
          # shellcheck disable=SC2046
          while [ $(mdfind "kMDItemContentType == 'com.apple.application-bundle' && kMDItemFSName == 'LibreOffice.app'" -onlyin '/Applications' | wc -l) -eq 0 ];
          do
            # shellcheck disable=SC2034
            TEMP=$(ls /Applications/LibreOffice.app 2>&- || true);
            echo " -> Please wait for Macintosh until it has indexed the /Applications/LibreOffice.app directory! ...";
            echo "    Sleeping 1 second.";
            echo "";
            sleep 1;
          done;

          ## Install language pack for LibreOffice
          echo " brew install --cask --no-quarantine libreoffice-language-pack";
          brew install --cask --no-quarantine libreoffice-language-pack;

        else
          echo "ERROR: Unfortunately LibreOffice cannot be found in the file system at the path /Applications/LibreOffice.app";
          echo "       Therefore a language pack can NOT be installed!!!";
        fi

        echo " xattr -crv /Applications/LibreOffice.app";
        xattr -crv /Applications/LibreOffice.app;
        echo "";

        if [[ "${FOUND_LIBREOFFICE_IN_DOCK}" -eq 0 ]]
        then
          echo "";
          echo " dockutil --add /Applications/LibreOffice.app --position ${POSITION_OF_LIBREOFFICE_IN_DOCK} --restart";
          dockutil --add /Applications/LibreOffice.app --position "${POSITION_OF_LIBREOFFICE_IN_DOCK}" --restart;
          echo "";
        fi

      else
        echo "==> WARNING: Unfortunately the libreoffice and libreoffice-language-pack packages are NOT available with the same version in the Homebrew repository.";
        echo "             Please do try again tomorrow or the day after and then surely LibreOffice can be updated including the language pack. :-)";
        echo "             libreoffice -> ${LIBREOFFICE_AVAILABLE_VERSION} / libreoffice-language-pack -> ${LIBREOFFICE_LANGPACK_AVAILABLE_VERSION}";
      fi
    else
      # ONLY LibreOffice has been installed. 
      echo "  brew upgrade --cask libreoffice";
      brew upgrade --cask libreoffice;

      echo " xattr -crv /Applications/LibreOffice.app";
      xattr -crv /Applications/LibreOffice.app;
      echo "";

      if [[ "${FOUND_LIBREOFFICE_IN_DOCK}" -eq 0 ]]
      then
        echo "";
        echo " dockutil --add /Applications/LibreOffice.app --position ${POSITION_OF_LIBREOFFICE_IN_DOCK} --restart";
        dockutil --add /Applications/LibreOffice.app --position "${POSITION_OF_LIBREOFFICE_IN_DOCK}" --restart;
        echo "";
      fi
    fi
  else
    echo "==> There is no update for LibreOffice.";
    echo "";
  fi
fi
echo "";


echo "==> Updating and installing available updates for brew itself and all cli utilities you installed through it:";
echo " brew update"
brew update
echo "";
echo " brew upgrade --formulae"
brew upgrade --formulae
echo "";
echo "";


echo "==> Updating brew casks (but NOT libreoffice):";
echo " brew outdated --casks --greedy | grep -v libreoffice | xargs brew upgrade --casks --greedy --force";
brew outdated --casks --greedy | grep -v libreoffice | xargs brew upgrade --casks --greedy --force


